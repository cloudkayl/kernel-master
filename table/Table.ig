GENERIC INTERFACE Table(Key, Value);
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
  Iterator = BRANDED OBJECT METHODS
    next(VAR k: Key.T; VAR v: Value.T): BOOLEAN;
    reset();
  END;
  Default <: T OBJECT METHODS
    init(sizeHint: CARDINAL := 0): Default;
    keyEqual(READONLY k1, k2: Key.T): BOOLEAN;
    keyHash(READONLY k: Key.T): Word.T
  END;
END Table.
