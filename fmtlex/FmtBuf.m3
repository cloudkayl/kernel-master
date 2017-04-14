MODULE FmtBuf EXPORTS FmtBuf;

IMPORT Word, Convert;

PROCEDURE Int(VAR (*INOUT*) b: T; n: INTEGER; base: Base := 10): CARDINAL =
  <* FATAL Convert.Failed *>
  BEGIN
    RETURN Convert.FromInt(b, n, base, prefix := FALSE)
  END Int;

PROCEDURE Unsigned(VAR (*INOUT*) b: T; n: Word.T; base: Base := 16): CARDINAL =
  <* FATAL Convert.Failed *>
  BEGIN
    RETURN Convert.FromUnsigned(b, n, base, prefix := FALSE)
  END Unsigned;

BEGIN
END FmtBuf.
