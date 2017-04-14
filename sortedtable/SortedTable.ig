GENERIC INTERFACE SortedTable(Key, Tbl);
CONST
  Brand = "(Sorted " & Tbl.Brand & ")";
  DefaultBrand = "(Default " & Brand & ")";
  (* A "SortedTable.Default" is revealed to have the brand "DefaultBrand". *)

TYPE
  T = Tbl.T OBJECT METHODS
    iterateOrdered(up: BOOLEAN := TRUE): Iterator
  END;
  Iterator = Tbl.Iterator OBJECT METHODS
    seek(READONLY key: Key.T)
  END;
  Default <: T OBJECT METHODS
    init(): Default;
  END;
END SortedTable.

