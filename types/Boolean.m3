MODULE Boolean;

IMPORT Word;

PROCEDURE Compare (a, b: T): [-1..1] =
  BEGIN
    RETURN ORD (a) - ORD (b);
  END Compare;

PROCEDURE Equal (a, b: T): BOOLEAN =
  BEGIN
    RETURN (a = b);
  END Equal;

PROCEDURE Hash (a: T): Word.T =
  BEGIN
    RETURN ORD (a);
  END Hash;

BEGIN
END Boolean.

