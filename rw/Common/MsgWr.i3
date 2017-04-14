INTERFACE MsgWr;

IMPORT Thread, Wr;

TYPE
  T = Wr.T OBJECT METHODS
    nextMsg() RAISES {Wr.Failure, Thread.Alerted};
  END;
(* "nextMsg" ends the current message, and starts the next. *)

(* The "nextMsg" method affects the abstract writer state as follows:
      
\begin{tabular}{ll}
        & \\
          "len(wr)"      &      is zero \\
          "c(wr)"        &      is empty \\
          "cur(wr)"      &      is zero \\
          "target(wr)"   &      is empty \\
          "closed(wr)"   &      is unchanged \\
          "seekable(wr)" &      is unchanged \\
          "buffered(wr)" &      is unchanged \\
        & \\
\end{tabular}

   Message writer buffers must be word-aligned in memory. More
   precisely, if byte "i" in the data stream is stored in the
   buffer at memory address "j", then "i" and "j" must be
   equal modulo the machine word size.
*)

END MsgWr.
