GENERIC MODULE Table(Key, Value);
IMPORT Word;

TYPE
  Public = T OBJECT METHODS
    init(sizeHint: CARDINAL := 0): Default;
    keyEqual(READONLY k1, k2: Key.T): BOOLEAN;
    keyHash(READONLY k: Key.T): Word.T
  END;

REVEAL
  Default = Public BRANDED DefaultBrand OBJECT
    minLogBuckets: CARDINAL; (* minimum value for Log_2(initial size) *)
    buckets: REF ARRAY OF EntryList;
    logBuckets: CARDINAL; (* CEILING(Log2(NUMBER(buckets^))) *)
    maxEntries: CARDINAL; (* maximum number of entries *)
    minEntries: CARDINAL; (* minimum number of entries *)
    numEntries: CARDINAL  (* current num of entries in table *)
  OVERRIDES
    get := Get;
    put := Put;
    delete := Delete;
    size := Size;
    iterate := Iterate;
    init := Init;
    keyEqual := KeyEqual;
    keyHash := KeyHash
  END;

TYPE EntryList = REF RECORD
    key: Key.T;
    value: Value.T;
    tail: EntryList
  END;

(*
 *  VAR  (*CONST*)
 *    Multiplier: INTEGER; 
 *)
CONST
  Multiplier: INTEGER = Word.Plus (Word.Shift (16_9e3779b9, 32), 16_7f4a7c15);


CONST
  MaxLogBuckets = BITSIZE(Word.T) - 2;
  MaxBuckets = Word.Shift(1, MaxLogBuckets);
  MinLogBuckets = 4;
  MinBuckets = Word.Shift(1, MinLogBuckets);

CONST
  (* Thresholds for rehashing the table: *)
  (* to avoid crazy oscillations, we must have MaxDensity > 2*MinDensity; *)
  (* to avoid excessive probes, we must try to keep MaxDensity low. *)
(*
 *  MaxDensity = 0.75; 
 *  MinDensity = 0.20; 
 *  IdealDensity = 0.50;
 *)
  (* Divide by 100 before using *)
  MaxDensity = 75; (* max numEntries/NUMBER(buckets) *)
  MinDensity = 20; (* min numEntries/NUMBER(buckets) *)
  IdealDensity = 50;

TYPE DefaultIterator = Iterator BRANDED OBJECT
    tbl: Default;
    this: EntryList; (* next entry to visit if non-NIL *)
    bucket: CARDINAL; (* next bucket if < NUMBER(tbl.buckets^) *)
    done: BOOLEAN; (* TRUE if next() has returned FALSE *)
  OVERRIDES
    next := Next;
    reset := Reset;
  END;


(*******************)
(* Default methods *)
(*******************)

PROCEDURE Init(tbl: Default; n: CARDINAL := 0): Default =
  BEGIN
(*
 *    WITH idealBuckets = CEILING(MIN(FLOAT(n) / IdealDensity,
 *                                    FLOAT(MaxBuckets))), 
 *)
    WITH idealBuckets = MIN(n * 100 DIV IdealDensity, MaxBuckets),
         minBuckets = MAX(MinBuckets, idealBuckets) DO
      tbl.minLogBuckets := Log_2(minBuckets)
    END;

    (* make sure clean exists before main body runs, but alloc once *)
    IF clean # NIL THEN
      clean := NEW(EntryList); 
    END;

    NewBuckets(tbl, tbl.minLogBuckets);
    tbl.numEntries := 0;
    RETURN tbl
  END Init;

PROCEDURE Get(tbl: Default; READONLY key: Key.T; VAR val: Value.T): BOOLEAN =
  VAR this: EntryList;
  BEGIN
    this := tbl.buckets[
              Word.RightShift(Word.Times(Key.Hash(key), Multiplier),
                              Word.Size - tbl.logBuckets)];
    WHILE this # NIL AND NOT Key.Equal(key, this.key) DO
      this := this.tail
    END;
    IF this # NIL THEN val := this.value; RETURN TRUE ELSE RETURN FALSE END
  END Get;

PROCEDURE Put(tbl: Default; READONLY key: Key.T; READONLY val: Value.T)
  : BOOLEAN =
  VAR this: EntryList;
  BEGIN
    WITH first = tbl.buckets[Word.RightShift(
                               Word.Times(Key.Hash(key), Multiplier),
                               Word.Size - tbl.logBuckets)] DO
      this := first;
      WHILE this # NIL AND NOT Key.Equal(key, this.key) DO
        this := this.tail
      END;
      IF this # NIL THEN
        this.value := val;
        RETURN TRUE
      ELSE
        first :=
          NEW(EntryList, key := key, value := val, tail := first);
        INC(tbl.numEntries);
        IF tbl.logBuckets < MaxLogBuckets
             AND tbl.numEntries > tbl.maxEntries THEN
          Rehash(tbl, tbl.logBuckets + 1) (* too crowded *)
        END;
        RETURN FALSE
      END
    END
  END Put;

VAR 
  clean: EntryList := NIL;

PROCEDURE Delete(tbl: Default; READONLY key: Key.T; VAR val: Value.T)
  : BOOLEAN =
  VAR this, prev: EntryList;
  BEGIN
    WITH first = tbl.buckets[Word.RightShift(
                               Word.Times(Key.Hash(key), Multiplier),
                               Word.Size - tbl.logBuckets)] DO
      this := first;
      prev := NIL;
      WHILE this # NIL AND NOT Key.Equal(key, this.key) DO
        prev := this;
        this := this.tail
      END;
      IF this # NIL THEN
        val := this.value;
        IF prev = NIL THEN
          first := this.tail
        ELSE
          prev.tail := this.tail
        END;
        DEC(tbl.numEntries);
        IF tbl.logBuckets > tbl.minLogBuckets
             AND tbl.numEntries < tbl.minEntries THEN
          Rehash(tbl, tbl.logBuckets - 1) (* too sparse *)
        END;
        IF clean # NIL THEN
          this^ := clean^;
        END;
        RETURN TRUE
      ELSE
        RETURN FALSE
      END
    END
  END Delete;

PROCEDURE Size(tbl: Default): CARDINAL =
  BEGIN
    RETURN tbl.numEntries
  END Size;

PROCEDURE Iterate(tbl: Default): Iterator =
  BEGIN
    RETURN NEW(DefaultIterator,
      tbl := tbl, this := NIL, bucket := 0, done := FALSE)
  END Iterate;

PROCEDURE KeyHash(<*UNUSED*> tbl: Default; READONLY k: Key.T): Word.T =
  BEGIN
    RETURN Key.Hash(k)
  END KeyHash;

PROCEDURE KeyEqual(<*UNUSED*> tbl: Default; READONLY k1, k2: Key.T): BOOLEAN =
  BEGIN
    RETURN Key.Equal(k1, k2)
  END KeyEqual;


(***********************)
(* Internal procedures *)
(***********************)

PROCEDURE Log_2(x: CARDINAL): CARDINAL =
  (* Return CEILING(LOG_2(x)) *)
  VAR
    log: CARDINAL := 0;
    n: CARDINAL := 1;
  BEGIN
    <* ASSERT x # 0 *>
    WHILE (log < MaxLogBuckets) AND (x > n) DO INC(log); n := n + n END;
    RETURN log
  END Log_2;

PROCEDURE NewBuckets(tbl: Default; logBuckets: CARDINAL) =
  (* Allocate "2^logBuckets" buckets. *)
  BEGIN
    WITH numBuckets = Word.LeftShift(1, logBuckets) DO
      tbl.buckets := NEW(REF ARRAY OF EntryList, numBuckets);
      WITH b = tbl.buckets^ DO
        FOR i := FIRST(b) TO LAST(b) DO b[i] := NIL END
      END;
      tbl.logBuckets := logBuckets;
(*
 *     tbl.maxEntries := ROUND(MaxDensity * FLOAT(numBuckets));
 *     tbl.minEntries := ROUND(MinDensity * FLOAT(numBuckets))
 *)
      tbl.maxEntries := MaxDensity * numBuckets DIV 100;
      tbl.minEntries := MinDensity * numBuckets DIV 100;

    END
  END NewBuckets;

PROCEDURE Rehash(tbl: Default; logBuckets: CARDINAL) =
  (* Reallocate "2^logBuckets" buckets, and rehash the entries into the new
     table. *)
  BEGIN
    <* ASSERT logBuckets <= MaxLogBuckets *>
    <* ASSERT logBuckets >= tbl.minLogBuckets *>
    WITH ob = tbl.buckets^ DO
      NewBuckets(tbl, logBuckets);
      WITH nb = tbl.buckets^ DO
        FOR i := FIRST(ob) TO LAST(ob) DO
          WITH obi = ob[i] DO
            VAR
              this: EntryList := obi;
              tail: EntryList;
            BEGIN
              obi := NIL;       (* ease collector's life *)
              WHILE this # NIL DO
                WITH nbh = nb[Word.RightShift(
                                Word.Times(
                                  Key.Hash(this.key), Multiplier),
                                Word.Size - logBuckets)] DO
                  tail := this.tail;
                  this.tail := nbh;
                  nbh := this;
                  this := tail
                END
              END
            END
          END
        END
      END
    END
  END Rehash;


(********************)
(* Iterator methods *)
(********************)

PROCEDURE Next(i: DefaultIterator; VAR key: Key.T; VAR val: Value.T): BOOLEAN =
  BEGIN
    BEGIN
      WHILE i.this = NIL AND i.bucket < NUMBER(i.tbl.buckets^) DO
        i.this := i.tbl.buckets^[i.bucket];
        INC(i.bucket)
      END;
      IF i.this # NIL THEN
        key := i.this.key;
        val := i.this.value;
        i.this := i.this.tail;
        RETURN TRUE
      ELSE
        <* ASSERT NOT i.done *>
        i.done := TRUE;
        RETURN FALSE
      END
    END
  END Next;

PROCEDURE Reset(i: DefaultIterator) =
  BEGIN
    i.this := NIL;
    i.bucket := 0;
    i.done := FALSE;
  END Reset;

BEGIN
  (* The multiplier == 2^BITSIZE(Word.T) / phi *)
(*
 *  IF BITSIZE (Word.T) = 32 THEN
 *    Multiplier := 16_9e3779b9;
 *  ELSIF BITSIZE (Word.T) = 64 THEN
 *    Multiplier := Word.Plus (Word.Shift (16_9e3779b9, 32), 16_7f4a7c15);
 *  ELSE
 *    <*ASSERT FALSE*>
 *  END;
 *)
END Table.
