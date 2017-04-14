INTERFACE Refany;

IMPORT Word;

TYPE T = REFANY;

CONST Brand = "Refany";

PROCEDURE Equal(r1, r2: T): BOOLEAN;
(* Return "r1 = r2". *)

PROCEDURE Hash(r: T): Word.T;
(* Cause a checked runtime error. *)

PROCEDURE Compare(r1, r2: T): [-1..1];
(* Cause a checked runtime error. *)


END Refany.
