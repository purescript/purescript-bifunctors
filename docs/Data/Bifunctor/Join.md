## Module Data.Bifunctor.Join

#### `Join`

``` purescript
data Join p a
  = Join (p a a)
```

`Join` turns a `Bifunctor` into a `Functor` by equating the
two type arguments.

##### Instances
``` purescript
instance joinFunctor :: (Bifunctor p) => Functor (Join p)
instance joinApply :: (Biapply p) => Apply (Join p)
instance joinApplicative :: (Biapplicative p) => Applicative (Join p)
```

#### `runJoin`

``` purescript
runJoin :: forall p a. Join p a -> p a a
```

Remove the `Join` constructor.


