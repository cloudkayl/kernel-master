MODULE Integer;

IMPORT Word;

PROCEDURE Equal(a, b: T): BOOLEAN =
  BEGIN
    RETURN a = b
  END Equal;

PROCEDURE Hash(a: T): Word.T =
  BEGIN
    RETURN a
  END Hash;

PROCEDURE Compare(a, b: T): [-1..1] =
  BEGIN
    IF a < b THEN RETURN -1
    ELSIF a = b THEN RETURN 0
    ELSE RETURN 1
    END
  END Compare;

BEGIN
END Integer.

