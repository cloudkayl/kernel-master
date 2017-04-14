(* A "TextRd.T", or text reader, is a reader that delivers the
   characters of a "TEXT" supplied when the reader was created.  Text
   readers are seekable, non-intermittent, and never raise "Failure"
   or "Alerted". *)

INTERFACE TextRd;

IMPORT Rd;

TYPE
  T <: Public;
  Public = Rd.T OBJECT METHODS init(t: TEXT): T END;

(* The call "rd.init(t)" initializes "rd" as a seekable,
   non-intermittent reader with:
| len(rd) = Text.Length(t)
| src(rd) = `characters of t`
| cur(rd) = 0

   It is a checked runtime error if "t = NIL". *)

PROCEDURE New(t: TEXT): T;
(* Equivalent to "NEW(T).init(t)". *)

PROCEDURE FromArray(len: INTEGER; a: REF ARRAY OF CHAR): T;
(* Save work by using a buffer passed in by caller. *)

END TextRd.
