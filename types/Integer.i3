INTERFACE Integer;

IMPORT Word;

TYPE T = INTEGER;

CONST Brand = "Integer";

PROCEDURE Equal(a, b: T): BOOLEAN;
(* Return "a = b". *)

PROCEDURE Hash(a: T): Word.T;
(* Return "a". *)

PROCEDURE Compare(a, b: T): [-1..1];
(* Return "-1" if "a < b", "0" if "a = b", or "+1" if "a > b". *)

END Integer.

