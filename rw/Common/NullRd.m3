MODULE NullRd;

IMPORT RdClass;

REVEAL
  T = Public BRANDED OBJECT
      OVERRIDES
        seek   := Seek;
        length := Length;
        init   := Init;
      END;

PROCEDURE Init (rd: T): T =
  BEGIN
    rd.st := 0;
    rd.lo := 0;
    rd.cur := 0;
    rd.hi := 0;
    rd.buff := NIL;
    rd.closed := FALSE;
    rd.seekable := TRUE;
    rd.intermittent := FALSE;
    RETURN rd;
  END Init;

PROCEDURE Seek (<*UNUSED*> rd: T; <*UNUSED*> pos: CARDINAL;
                                  <*UNUSED*> dontBlock: BOOLEAN):
  RdClass.SeekResult =
  BEGIN
    RETURN (RdClass.SeekResult.Eof);
  END Seek;

PROCEDURE Length(<*UNUSED*> rd: T): INTEGER =
  BEGIN RETURN 0; END Length;

BEGIN
END NullRd.


                
  
