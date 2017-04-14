INTERFACE FmtBuf;

IMPORT Fmt, Word;

TYPE
  T = ARRAY OF CHAR;
  Base = Fmt.Base;

PROCEDURE Int(VAR (*OUT*) b: T; n: INTEGER; base: Base := 10): CARDINAL;
PROCEDURE Unsigned(VAR (*OUT*) b: T; n: Word.T; base: Base := 16): CARDINAL;

END FmtBuf.
