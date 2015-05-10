## Module Data.Bifunctor.Join

#### `Join`

``` purescript
data Join p a
  = Join (p a a)
```

##### Instances
``` purescript
instance joinFunctor :: (Bifunctor p) => Functor (Join p)
instance joinApply :: (Biapply p) => Apply (Join p)
instance joinApplicative :: (Biapplicative p) => Applicative (Join p)
```

`Join` turns a `Bifunctor` into a `Functor` by equating the
two type arguments.

#### `runJoin`

``` purescript
runJoin :: forall p a. Join p a -> p a a
```

Remove the `Join` constructor.


