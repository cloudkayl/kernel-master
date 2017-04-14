INTERFACE NullWr;

IMPORT Wr;

TYPE
  T <: Public;
  Public = Wr.T OBJECT METHODS init (): T END;
  (* An initialized NullWr.T returned by NEW(T).init() is an empty
     output stream with

        len (wr) = 0
        c (wr) = ''
        seekable (rd) = FALSE *)

END NullWr.
