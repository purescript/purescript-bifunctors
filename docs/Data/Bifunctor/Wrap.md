## Module Data.Bifunctor.Wrap

#### `Wrap`

``` purescript
data Wrap p a b
  = Wrap (p a b)
```

A `newtype` wrapper which provides a `Functor` over the second argument of
a `Bifunctor`

##### Instances
``` purescript
instance wrapBifunctor :: (Bifunctor p) => Bifunctor (Wrap p)
instance wrapFunctor :: (Bifunctor p) => Functor (Wrap p a)
instance wrapBiapply :: (Biapply p) => Biapply (Wrap p)
instance wrapBiapplicative :: (Biapplicative p) => Biapplicative (Wrap p)
```

#### `unwrap`

``` purescript
unwrap :: forall p a b. Wrap p a b -> p a b
```

Remove the `Wrap` constructor.


