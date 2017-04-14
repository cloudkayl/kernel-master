lm3Store(St, T, Val): trait
  % Instantiated by LM3 once per object/record field type.
  includes
    FiniteMap(St, T, Val)
  introduces
    __.__: T, St -> Val
  asserts
    \forall t: T, st: St
      t.st == apply(st, t);
