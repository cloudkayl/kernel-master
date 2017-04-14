string(E): trait

  % Handbook String trait (List plus index and substring),
  % plus a put operator.

  includes String(E, String$E)
  introduces put: String$E, Int, E -> String$E
  asserts \forall s: String$E, i, j: Int, e: E
    put(s, i, e)[j] == if i = j then e else s[j]
