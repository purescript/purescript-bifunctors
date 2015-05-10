## Module Data.Bifunctor.Product

#### `Product`

``` purescript
data Product f g a b
  = Pair (f a b) (g a b)
```

##### Instances
``` purescript
instance productBifunctor :: (Bifunctor f, Bifunctor g) => Bifunctor (Product f g)
instance productBiapply :: (Biapply f, Biapply g) => Biapply (Product f g)
instance productBiapplicative :: (Biapplicative f, Biapplicative g) => Biapplicative (Product f g)
```

The product of two `Bifunctor`s.


