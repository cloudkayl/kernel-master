INTERFACE NullRd;

IMPORT Rd;

TYPE
  T <: Public;
  Public = Rd.T OBJECT METHODS init (): T END;
  (* An initialized NullRd.T is an empty input stream:
        len (rd) = 0
        src (rd) = 'eof'
        seekable (rd) = TRUE
        intermittent (rd) = FALSE  *)

END NullRd.
