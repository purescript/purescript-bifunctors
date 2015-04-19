# Module Documentation

## Module Data.Bifunctor.Flip

#### `Flip`

``` purescript
data Flip p a b
  = Flip (p b a)
```

Flips the order of the type arguments of a `Bifunctor`.

#### `runFlip`

``` purescript
runFlip :: forall p a b. Flip p a b -> p b a
```

Remove the `Flip` constructor.

#### `flipBifunctor`

``` purescript
instance flipBifunctor :: (Bifunctor p) => Bifunctor (Flip p)
```


#### `flipFunctor`

``` purescript
instance flipFunctor :: (Bifunctor p) => Functor (Flip p a)
```


#### `flipBiapply`

``` purescript
instance flipBiapply :: (Biapply p) => Biapply (Flip p)
```


#### `flipBiapplicative`

``` purescript
instance flipBiapplicative :: (Biapplicative p) => Biapplicative (Flip p)
```




