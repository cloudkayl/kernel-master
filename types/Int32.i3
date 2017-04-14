INTERFACE Int32;

IMPORT Word;

TYPE T = BITS 32 FOR [ -16_7fffffff-1 .. 16_7fffffff ];

CONST Brand = "Int32";

PROCEDURE Equal(a, b: T): BOOLEAN;
(* Return "a = b". *)

PROCEDURE Hash(a: T): Word.T;
(* Return "a". *)

PROCEDURE Compare(a, b: T): [-1..1];
(* Return "-1" if "a < b", "0" if "a = b", or "+1" if "a > b". *)

END Int32.

