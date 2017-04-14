VAR

(* If "useCurrentRounding" is "TRUE", then the procedures in "FmtBuf" for
   formatting real numbers use the current rounding mode. In this case, the
   value of the global variable "testRoundingMode" is ignored.

   If "useCurrentRounding" is "FALSE", then these procedures use
   "testRoundingMode" as the rounding mode, even if it is not a rounding
   mode supported by the underlying architecture. *)

END FmtBufTest.
