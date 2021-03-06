GENERIC MODULE ArraySort (Elem);

PROCEDURE Sort (VAR a: ARRAY OF Elem.T;  cmp := Elem.Compare) =
  BEGIN
    QuickSort (a, 0, NUMBER (a), cmp);
    InsertionSort (a, 0, NUMBER (a), cmp);
  END Sort;

PROCEDURE QuickSort (VAR a: ARRAY OF Elem.T;  lo, hi: INTEGER;
                     cmp := Elem.Compare) =
  CONST CutOff = 9;
  VAR i, j: INTEGER;  key, tmp: Elem.T;
  BEGIN
    WHILE (hi - lo > CutOff) DO (* sort a[lo..hi) *)

      (* use median-of-3 to select a key *)
      i := (hi + lo) DIV 2;
      IF cmp (a[lo], a[i]) < 0 THEN
        IF cmp (a[i], a[hi-1]) < 0 THEN
          key := a[i];
        ELSIF cmp (a[lo], a[hi-1]) < 0 THEN
          key := a[hi-1];  a[hi-1] := a[i];  a[i] := key;
        ELSE
          key := a[lo];  a[lo] := a[hi-1];  a[hi-1] := a[i];  a[i] := key;
        END;
      ELSE (* a[lo] >= a[i] *)
        IF cmp (a[hi-1], a[i]) < 0 THEN
          key := a[i];  tmp := a[hi-1];  a[hi-1] := a[lo];  a[lo] := tmp;
        ELSIF cmp (a[lo], a[hi-1]) < 0 THEN
          key := a[lo];  a[lo] := a[i];  a[i] := key;
        ELSE
          key := a[hi-1];  a[hi-1] := a[lo];  a[lo] := a[i];  a[i] := key;
        END;
      END;

      (* partition the array *)
      i := lo+1;  j := hi-2;

      (* find the first hole *)
      WHILE cmp (a[j], key) > 0 DO DEC (j) END;
      tmp := a[j];
      DEC (j);

      LOOP
        IF (i > j) THEN EXIT END;

        WHILE cmp (a[i], key) < 0 DO INC (i) END;
        IF (i > j) THEN EXIT END;
        a[j+1] := a[i];
        INC (i);

        WHILE cmp (a[j], key) > 0 DO DEC (j) END;
        IF (i > j) THEN  IF (j = i-1) THEN  DEC (j)  END;  EXIT  END;
        a[i-1] := a[j];
        DEC (j);
      END;

      (* fill in the last hole *)
      a[j+1] := tmp;
      i := j+2;

      (* then, recursively sort the smaller subfile *)
      IF (i - lo < hi - i)
        THEN  QuickSort (a, lo, i-1, cmp);   lo := i;
        ELSE  QuickSort (a, i, hi, cmp);     hi := i-1;
      END;

    END; (* WHILE (hi-lo > CutOff) *)
  END QuickSort;


PROCEDURE InsertionSort (VAR a: ARRAY OF Elem.T;  lo, hi: INTEGER;
                         cmp := Elem.Compare) =
  VAR j: INTEGER;  key: Elem.T;
  BEGIN
    FOR i := lo+1 TO hi-1 DO
      key := a[i];
      j := i-1;
      WHILE (j >= lo) AND cmp (key, a[j]) < 0 DO
        a[j+1] := a[j];
        DEC (j);
      END;
      a[j+1] := key;
    END;
  END InsertionSort;

BEGIN
END ArraySort.
