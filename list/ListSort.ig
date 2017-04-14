GENERIC INTERFACE ListSort(Elem, ElemList);
(* Where "Elem.T" is not an open array type, "ElemList" equals "List(Elem)",
   and "Elem" contains

| CONST Brand = <text-constant>;
| PROCEDURE Compare(e1, e2: Elem.T): [-1..1];

   "Brand" must be a text constant. It will be used to construct a brand for
   any generic types instantiated with the "ListSort" interface. For a
   non-generic interface, we recommend choosing the name of the interface.

   "Compare" must be a total order. It may be declared with any parameter
   mode, but must have no visible side-effects.
*)

CONST Brand = "(ListSort " & Elem.Brand & ")";

TYPE T = ElemList.T;

PROCEDURE Sort(l: T; c := Elem.Compare): T;
PROCEDURE SortD(l: T; c := Elem.Compare): T;
(* Sort a list in ascending order using "c" to compare pairs of
   elements of "l". *)

(* The implementation is time- and cons-efficient but not guaranteed
   to be stable.  "Sort" copies the cells; "SortD" modifies the "tail"
   fields of the existing cells.  *)

END ListSort.

