(* The UnsafeRd interface is similar to Rd, but GetChar, GetSub and
Eof are the only operations that are sufficiently performance-critical
to be included.

   REVEAL RdClass.Private <: MUTEX

in order to satisfy the constraint that the revealed supertypes of an
opaque type be totally ordered.  *)

INTERFACE UnsafeRd;
IMPORT Rd, Thread; 
FROM Thread IMPORT Alerted;
FROM Rd IMPORT Failure, EndOfFile;

REVEAL
  Rd.T <: Thread.Mutex;

PROCEDURE FastGetChar(rd: Rd.T): CHAR RAISES {EndOfFile, Failure, Alerted};
(* Like Rd.GetChar, but rd must be locked. *)

PROCEDURE FastGetSub(rd: Rd.T; VAR (*OUT*) str: ARRAY OF CHAR): CARDINAL
    RAISES {Failure, Alerted};
(* Like Rd.GetSub, but rd must be locked. *)

PROCEDURE FastEOF(rd: Rd.T): BOOLEAN RAISES {Failure, Alerted};
(* Like Rd.EOF, but rd must be locked. *)

PROCEDURE FastUnGetChar(rd: Rd.T) RAISES {};
(* Like Rd.UnGetChar, but rd must be locked. *)

PROCEDURE FastClose (rd: Rd.T) RAISES {Failure, Alerted};

END UnsafeRd.

