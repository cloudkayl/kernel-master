MODULE NullWr;

IMPORT WrClass;

CONST
  BuffSize = 1024;

REVEAL
  T = Public BRANDED OBJECT
      OVERRIDES
        seek:= Seek;
        putString := PutString;
        init := Init;
      END;

PROCEDURE Init (wr: T): T =
  BEGIN
    wr.st := 0;
    wr.lo := 0;
    wr.cur := 0;
    wr.hi := BuffSize;
    IF (wr.buff = NIL) THEN
      wr.buff := NEW(REF ARRAY OF CHAR, BuffSize);
    END;
    wr.closed := FALSE;
    wr.seekable := FALSE;
    wr.buffered := TRUE;
    RETURN wr;
  END Init;

PROCEDURE Seek (wr: T; n: CARDINAL) =
  BEGIN
    wr.lo := n;
    wr.cur := n;
    wr.hi := n + BuffSize;
  END Seek;

PROCEDURE PutString (wr: T; READONLY a: ARRAY OF CHAR) =
  BEGIN
    Seek(wr, wr.cur + NUMBER(a));
  END PutString;

BEGIN
END NullWr.
