MODULE ASCII;

IMPORT Word;

BEGIN
  FOR c := FIRST(Upper) TO LAST(Upper) DO Upper[c] := c END;
  FOR c := 'a' TO 'z' DO
    Upper[c] := VAL (ORD (c) - ORD ('a') + ORD ('A'), CHAR);
  END;

  FOR c := FIRST(Lower) TO LAST(Lower) DO Lower[c] := c;  END;
  FOR c := 'A' TO 'Z' DO
    Lower[c] := VAL (ORD (c) - ORD ('A') + ORD ('a'), CHAR);
  END;

  FOR c := FIRST(Control) TO LAST(Control) DO
    IF (c IN Graphics)
      THEN Control[c] := VAL (Word.And (ORD (c), 31), CHAR);
      ELSE Control[c] := c;
    END;
  END;
END ASCII.
