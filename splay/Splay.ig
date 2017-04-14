GENERIC INTERFACE Splay(Key, Value);

TYPE
  T <: Public;

  Proc = PROCEDURE (key: Key.T; value: Value.T);

  Public = OBJECT 
  METHODS
    splay(key: Key.T);
    insert(key: Key.T; value: Value.T): BOOLEAN;
    delete(key: Key.T; VAR elem_val: Value.T): BOOLEAN;
    find(key: Key.T; VAR value: Value.T): BOOLEAN;
    findRank(rank: INTEGER; VAR elem_key: Key.T; VAR elem_val: Value.T): BOOLEAN;
    rootRank(): CARDINAL;
    getRoot(VAR key: Key.T; VAR value: Value.T): BOOLEAN;
    visit(Pre, In, Post: Proc);
  END;

END Splay.
