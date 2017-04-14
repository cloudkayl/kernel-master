

INTERFACE Atom;

TYPE T <: REFANY;

CONST Brand = "Atom-1.0";

PROCEDURE FromText(t: TEXT): T;
(* Return the unique atom "a" such that for any text "u", if
   "Text.Equal(u, t)", then "FromText(u) = a".  *)

PROCEDURE ToText(a: T): TEXT;
(* Return a text "t" such that "FromText(t) = a". *)

PROCEDURE Equal(a1, a2: T): BOOLEAN;
(* Return "a1 = a2". *)

PROCEDURE Hash(a: T): INTEGER;
(* Return a hash code for "a" by taking the image of "ToText(a)"
   under some fixed hash function.  *)

PROCEDURE Compare(a1, a2: T): [-1..1];
(* Cause a checked runtime error. *)

END Atom.

