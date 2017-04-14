UNSAFE MODULE Refany;

IMPORT Word, RT0;

PROCEDURE Equal(r1, r2: T): BOOLEAN = BEGIN RETURN r1 = r2 END Equal;

<* UNUSED *> EXCEPTION Error; (* <*FATAL Error*>*)

(*
PROCEDURE Compare (<*UNUSED*> r1, r2: T): [-1 .. 1] =
  BEGIN
    RAISE Error
  END Compare;
*)

VAR
  hashCnt: INTEGER := 0;

PROCEDURE Hash(r: T): Word.T = 
  VAR
    hash: Word.T;
  BEGIN
    IF RT0.MaxHash = 0 THEN
      RETURN 0;
    END;
    WITH header = LOOPHOLE(LOOPHOLE(r, ADDRESS) - ADRSIZE(RT0.RefHeader),
                           UNTRACED REF RT0.RefHeader) 
     DO
      IF header.hash = 0 THEN
        INC(hashCnt);
        header.hash := Word.And(hashCnt, RT0.MaxHash);
      END;
      hash := Word.Or(Word.Shift(header.typecode, 16), header.hash);
      RETURN hash;
    END;
  END Hash;
  
PROCEDURE Compare (r1, r2: T): [-1 .. 1] =
  VAR
    w1: Word.T := LOOPHOLE(r1, Word.T);
    w2: Word.T := LOOPHOLE(r2, Word.T);
  BEGIN
    IF w1 = w2 THEN
      RETURN 0;
    ELSIF Word.LT(w1,w2) THEN
      RETURN -1;
    ELSE
      RETURN 1;
    END;
  END Compare;

BEGIN
END Refany.

