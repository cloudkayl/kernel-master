INTERFACE ASCII;
CONST
  NUL = '\000';    SOH = '\001';    STX = '\002';    ETX = '\003';
  EOT = '\004';    ENQ = '\005';    ACK = '\006';    BEL = '\007';
  BS  = '\010';    HT  = '\011';    NL  = '\012';    VT  = '\013';
  NP  = '\014';    CR  = '\015';    SO  = '\016';    SI  = '\017';
  DLE = '\020';    DC1 = '\021';    DC2 = '\022';    DC3 = '\023';
  DC4 = '\024';    NAK = '\025';    SYN = '\026';    ETB = '\027';
  CAN = '\030';    EM  = '\031';    SUB = '\032';    ESC = '\033';
  FS  = '\034';    GS  = '\035';    RS  = '\036';    US  = '\037';
  SP  = '\040';    DEL = '\177';

TYPE
  Range = ['\000'..'\377'];
    (* Characters which are representable in both 8 bit and unicode
       characters. *)

  Set = SET OF Range;

CONST
  All           = Set{FIRST(Range).. LAST(Range)};
  Asciis        = Set{'\000'.. '\177'};
  Controls      = Set{'\000'.. '\037', '\177'};
  Spaces        = Set{' ', '\t', '\n', '\r', '\f'};
  Digits        = Set{'0'.. '9'};
  Uppers        = Set{'A'.. 'Z'};
  Lowers        = Set{'a'.. 'z'};
  Letters       = Uppers + Lowers;
  AlphaNumerics = Letters + Digits;
  Graphics      = Asciis - Controls;
  Punctuation   = Graphics - AlphaNumerics;

VAR
  Upper   : ARRAY Range OF Range;
  Lower   : ARRAY Range OF Range;
  Control : ARRAY Range OF Range;
  (* These constant arrays implement character conversions (mappings):

         Upper[c]   = the upper-case equivalent of c if c is a letter, o.w. c
         Lower[c]   = the lower-case equivalent of c if c is a letter, o.w. c
         Control[c] = the control-shifted equivalent of c if c is in Graphics
                       (i.e. BitAnd( c, 037B )), o.w. c
    *)

END ASCII.
