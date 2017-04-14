

IMPORT Fmt, FmtBuf;

CONST

TYPE
  NumAttr = RECORD
    class: Class;
    kind: IEEEKind;
    sign: [0..1];
    maxExpDigits: CARDINAL;
    len: CARDINAL;
    exp: INTEGER;
    errorSign: [-1..1];
  END;
  Digits = ARRAY OF [0..9];

TYPE
  FmtRec = RECORD
    prec: CARDINAL;
    literal: BOOLEAN;
  END;


END FmtBufF.
