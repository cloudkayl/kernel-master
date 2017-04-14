PROCEDURE FindString (         rd          : Rd.T;
                      READONLY pattern     : ARRAY OF CHAR;
                               canonicalize: Canonicalize    := NIL):
  [-1 .. LAST(CARDINAL)] RAISES {Rd.Failure, Thread.Alerted};
(* = Find(rd, Text.FromSub(pattern), canonicalize). *)

PROCEDURE FindChar (rd          : Rd.T;
                    pattern     : CHAR;
                    canonicalize: Canonicalize := NIL):
  [-1 .. LAST(CARDINAL)] RAISES {Rd.Failure, Thread.Alerted};
(* = Find(rd, Text.FromChar(pattern), canonicalize). *)

PROCEDURE FailureText (f: AtomList.T): TEXT;
(* Rd.i3 says: "EXCEPTION Failure (AtomList.T)".

   FailureText returns a text describing the failure "f".
   Returns either "NIL" or the names of the Atom.ToText of each
   element of this list separated by colons.
   *)

TYPE
  Canonicalize = PROCEDURE(ch: CHAR): CHAR;

PROCEDURE ToUpperCaseASCII(ch: CHAR): CHAR;
  (* Converts ASCII lower case characters to upper case, returns all
     other characters unchanged.  See ASCII.i3. *)

END RdUtils.
