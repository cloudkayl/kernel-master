INTERFACE Fmt;

IMPORT Word;

PROCEDURE Bool(b: BOOLEAN): TEXT;
(* Format "b" as {\tt \char'42TRUE\char'42} or  {\tt \char'42FALSE\char'42}. *)

PROCEDURE Char(c: CHAR): TEXT;
(* Return a text containing the character "c". *)

TYPE Base = [2..16];

PROCEDURE Int(n: INTEGER; base: Base := 10): TEXT;
PROCEDURE Unsigned(n: Word.T; base: Base := 16): TEXT;
TYPE Align = {Left, Right};

PROCEDURE Pad(
    text: TEXT;
    length: CARDINAL;
    padChar: CHAR := ' ';
    align: Align := Align.Right): TEXT;
(* If "Text.Length(text) >= length", then "text" is returned
   unchanged.  Otherwise, "text" is padded with "padChar" until it has
   the given "length".  The text goes to the right or left, according
   to "align". *)

PROCEDURE F(fmt: TEXT; t1, t2, t3, t4, t5: TEXT := NIL)
  : TEXT;
(* Uses "fmt" as a format string. The result is a copy of "fmt" in
   which all format specifiers have been replaced, in order, by the
   text arguments "t1", "t2", etc. *)

(* A format specifier contains a field width, alignment and one of two
   padding characters. The procedure "F" evaluates the specifier and
   replaces it by the corresponding text argument padded as it would
   be by a call to "Pad" with the specified field width, padding
   character and alignment.

   The syntax of a format specifier is:
| %[-]{0-9}s
   that is, a percent character followed by an optional minus sign, an
   optional number and a compulsory terminating "s".

   If the minus sign is present the alignment is "Align.Left",
   otherwise it is "Align.Right". The alignment corresponds to the
   "align" argument to "Pad".

   The number specifies the field width (this corresponds to the
   "length" argument to "Pad"). If the number is omitted it defaults
   to zero.

   If the number is present and starts with the digit "0" the padding character
   is "'0'"; otherwise it is the space character. The padding character
   corresponds to the "padChar" argument to "Pad".

   It is a checked runtime error if "fmt" is "NIL" or the number of
   format specifiers in "fmt" is not equal to the number of non-nil
   arguments to "F".

   Non-nil arguments to "F" must precede any "NIL" arguments; it is a
   checked runtime error if they do not.

   If "t1" to "t5" are all "NIL" and "fmt" contains no format
   specifiers, the result is "fmt".

   Examples:
| F("%s %s\n", "Hello", "World") `returns` "Hello World\n".
| F("%s", Int(3))                `returns` "3"
| F("%2s", Int(3))               `returns` " 3"
| F("%-2s", Int(3))              `returns` "3 "
| F("%02s", Int(3))              `returns` "03"
| F("%-02s", Int(3))             `returns` "30"
| F("%s", "%s")                  `returns` "%s"
| F("%s% tax", Int(3))           `returns` "3% tax"

   The following examples are legal but pointless:
| F("%-s", Int(3))               `returns` "3"
| F("%0s", Int(3))               `returns` "3"
| F("%-0s", Int(3))              `returns` "3"
*)

PROCEDURE FN(fmt: TEXT; READONLY texts: ARRAY OF TEXT)
  : TEXT;


(* Example:

| FN("%s %s %s %s %s %s %s",
|   ARRAY OF TEXT{"Too", "many", "arguments",
|     "for", "F", "to", "handle"})

   returns {\tt \char'42Too many arguments for F to handle\char'42}.
*)

(* format an ADDRESS *)
PROCEDURE Addr (a: ADDRESS) : TEXT;

(* format a REF *)
PROCEDURE Ref (r: REFANY) : TEXT;

END Fmt.




