
hash(T, R): trait
  % Gives the signature of a hash function from T to R, specifying
  % no properties--other than that it is a function, i.e.,
  %
  %     x = y => hash(x) = hash(y)

  introduces hash: T -> R
