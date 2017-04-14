MODULE TextRd;

IMPORT RdClass, Text;

REVEAL
  T = Public BRANDED OBJECT
      OVERRIDES
        seek   := Seek;
        length := Length;
        init   := Init;
      END;

PROCEDURE Init (rd: T; t: TEXT): T =
  VAR len := Text.Length (t);
  BEGIN
    IF (rd.buff = NIL) OR (len > NUMBER (rd.buff^)) THEN
      rd.buff := NEW(REF ARRAY OF CHAR, len);
    END;
    Text.SetChars(rd.buff^, t);
    rd.st := 0;
    rd.lo := 0;
    rd.cur := 0;
    rd.hi := len;
    rd.closed := FALSE;
    rd.seekable := TRUE;
    rd.intermittent := FALSE;
    RETURN rd;
  END Init;

PROCEDURE New(t: TEXT): T = BEGIN RETURN NEW(T).init(t); END New;

PROCEDURE FromArray(len: INTEGER; a: REF ARRAY OF CHAR): T =
  BEGIN
    WITH rd = NEW(T) DO
      rd.buff := a;
      rd.st := 0;
      rd.lo := 0;
      rd.cur := 0;
      rd.hi := len;
      rd.closed := FALSE;
      rd.seekable := TRUE;
      rd.intermittent := FALSE;
      RETURN rd;
    END;
  END FromArray;

PROCEDURE Seek (rd: T; pos: CARDINAL;
               <*UNUSED*> dontBlock: BOOLEAN): RdClass.SeekResult =
  BEGIN
    IF pos >= rd.hi THEN
      rd.cur := rd.hi;
      RETURN RdClass.SeekResult.Eof;
    ELSE
      rd.cur := pos;
      RETURN RdClass.SeekResult.Ready; END;
  END Seek;

PROCEDURE Length (rd: T): INTEGER =
  BEGIN
    RETURN rd.hi;
  END Length;

BEGIN
END TextRd.

