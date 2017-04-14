INTERFACE TextWr;

IMPORT Wr;

TYPE
  T <: Public;
  Public = Wr.T OBJECT METHODS init(): T END;

(* The call "wr.init()" initializes "wr" to be a seekable writer with
   "c(wr)" set to the empty sequence and "cur(wr)" to 0.  The
   writer has no upper bound on its length.*)

PROCEDURE New(): T;
(* Equivalent to "NEW(T).init()". *)

PROCEDURE ToText(wr: T): TEXT;
(* Return "c(wr)", resetting "c(wr)" to the empty sequence and
   "cur(wr)" to 0. *)

END TextWr.

