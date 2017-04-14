INTERFACE MsgRd;

IMPORT Thread, Rd;

TYPE
  T = Rd.T OBJECT METHODS
    nextMsg() : BOOLEAN RAISES {Rd.Failure, Thread.Alerted};
  END;
(* The "nextMsg" method advances to the next message. A return value
   of "TRUE" indicates the presence of a new message. "FALSE" indicates
   that no next message is present, and that the end of the stream of
   messages has been reached. *)
      
(* The "nextMsg" methods affects the abstract reader state as follows:
    
\begin{tabular}{ll}
        & \\
        "len(rd)"          &   is the length of the next message \\
        "src(rd)"          &   is the contents of the next message \\
        "cur(rd)"          &   is zero \\
        "avail(rd)"        &   is unspecified \\
        "closed(rd)"       &   is unchanged \\ 
        "seekable(rd)"     &   is unchanged \\
        "intermittent(rd)" &   is unchanged \\
        & \\
\end{tabular}

   Message reader buffers must be word-aligned in memory. More
   precisely, if byte "i" in the data stream is stored in the
   buffer at memory address "j", then "i" and "j" must be
   equal modulo the machine word size.
*)

END MsgRd.

    
