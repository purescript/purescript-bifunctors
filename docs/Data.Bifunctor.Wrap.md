# Module Documentation

## Module Data.Bifunctor.Wrap

#### `Wrap`

``` purescript
data Wrap p a b
  = Wrap (p a b)
```

A `newtype` wrapper which provides a `Functor` over the second argument of
a `Bifunctor`

#### `unwrap`

``` purescript
unwrap :: forall p a b. Wrap p a b -> p a b
```

Remove the `Wrap` constructor.

#### `wrapBifunctor`

``` purescript
instance wrapBifunctor :: (Bifunctor p) => Bifunctor (Wrap p)
```


#### `wrapFunctor`

``` purescript
instance wrapFunctor :: (Bifunctor p) => Functor (Wrap p a)
```


#### `wrapBiapply`

``` purescript
instance wrapBiapply :: (Biapply p) => Biapply (Wrap p)
```


#### `wrapBiapplicative`

``` purescript
instance wrapBiapplicative :: (Biapplicative p) => Biapplicative (Wrap p)
```




