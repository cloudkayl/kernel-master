INTERFACE Boolean;

IMPORT Word;

TYPE T = BOOLEAN;

CONST Brand = "Boolean";

PROCEDURE Compare (a, b: T): [-1..1];
(* == RETURN (a - b) *)

PROCEDURE Equal (a, b: T): BOOLEAN;
(* == RETURN (a = b) *)

PROCEDURE Hash (a: T): Word.T;
(* == RETURN ORD (a) *)

END Boolean.












