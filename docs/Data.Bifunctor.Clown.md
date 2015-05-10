## Module Data.Bifunctor.Clown

#### `Clown`

``` purescript
data Clown f a b
  = Clown (f a)
```

##### Instances
``` purescript
instance clownBifunctor :: (Functor f) => Bifunctor (Clown f)
instance clownFunctor :: Functor (Clown f a)
instance clownBiapply :: (Apply f) => Biapply (Clown f)
instance clownBiapplicative :: (Applicative f) => Biapplicative (Clown f)
```

Make a `Functor` over the first argument of a `Bifunctor`

#### `runClown`

``` purescript
runClown :: forall f a b. Clown f a b -> f a
```


