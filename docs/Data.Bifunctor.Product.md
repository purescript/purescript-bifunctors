# Module Documentation

## Module Data.Bifunctor.Product

#### `Product`

``` purescript
data Product f g a b
  = Pair (f a b) (g a b)
```

The product of two `Bifunctor`s.

#### `productBifunctor`

``` purescript
instance productBifunctor :: (Bifunctor f, Bifunctor g) => Bifunctor (Product f g)
```


#### `productBiapply`

``` purescript
instance productBiapply :: (Biapply f, Biapply g) => Biapply (Product f g)
```


#### `productBiapplicative`

``` purescript
instance productBiapplicative :: (Biapplicative f, Biapplicative g) => Biapplicative (Product f g)
```




