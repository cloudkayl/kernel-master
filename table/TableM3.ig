
(* "Table" is a generic interface defining partial maps that support
   update and iteration.
   \index{map!updatable}
*)

GENERIC INTERFACE TableM3(Key, Value);


IMPORT Word;

CONST
  Brand = "(Table " & Key.Brand & " " & Value.Brand & ")";
  DefaultBrand = "(Default " & Brand & ")";
  (* A "Table.Default" is revealed to have the brand "DefaultBrand". *)

TYPE
  T = OBJECT METHODS
    get(READONLY k: Key.T; VAR v: Value.T): BOOLEAN;
    put(READONLY k: Key.T; READONLY v: Value.T): BOOLEAN;
    delete(READONLY k: Key.T; VAR v: Value.T): BOOLEAN;
    size(): CARDINAL;
    iterate(): Iterator
  END;
  Iterator = OBJECT METHODS
    next(VAR k: Key.T; VAR v: Value.T): BOOLEAN
  END;
  Default <: T OBJECT METHODS
    init(sizeHint: CARDINAL := 0): Default;
    keyEqual(READONLY k1, k2: Key.T): BOOLEAN;
    keyHash(READONLY k: Key.T): Word.T
  END;
END TableM3.

