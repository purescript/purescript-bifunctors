# Module Documentation

## Module Data.Bifunctor.Clown

#### `Clown`

``` purescript
data Clown f a b
  = Clown (f a)
```

Make a `Functor` over the first argument of a `Bifunctor`

#### `runClown`

``` purescript
runClown :: forall f a b. Clown f a b -> f a
```


#### `clownBifunctor`

``` purescript
instance clownBifunctor :: (Functor f) => Bifunctor (Clown f)
```


#### `clownFunctor`

``` purescript
instance clownFunctor :: Functor (Clown f a)
```


#### `clownBiapply`

``` purescript
instance clownBiapply :: (Apply f) => Biapply (Clown f)
```


#### `clownBiapplicative`

``` purescript
instance clownBiapplicative :: (Applicative f) => Biapplicative (Clown f)
```




