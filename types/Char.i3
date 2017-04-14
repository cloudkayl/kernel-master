INTERFACE Char;

IMPORT Word;

TYPE T = CHAR;

CONST Brand = "Char";

PROCEDURE Compare (a, b: T): [-1..1];
(* == RETURN (a - b) *)

PROCEDURE Equal (a, b: T): BOOLEAN;
(* == RETURN (a = b) *)

PROCEDURE Hash (a: T): Word.T;
(* == RETURN ORD (a) *)

END Char.
