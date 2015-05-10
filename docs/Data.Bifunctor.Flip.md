## Module Data.Bifunctor.Flip

#### `Flip`

``` purescript
data Flip p a b
  = Flip (p b a)
```

##### Instances
``` purescript
instance flipBifunctor :: (Bifunctor p) => Bifunctor (Flip p)
instance flipFunctor :: (Bifunctor p) => Functor (Flip p a)
instance flipBiapply :: (Biapply p) => Biapply (Flip p)
instance flipBiapplicative :: (Biapplicative p) => Biapplicative (Flip p)
```

Flips the order of the type arguments of a `Bifunctor`.

#### `runFlip`

``` purescript
runFlip :: forall p a b. Flip p a b -> p b a
```

Remove the `Flip` constructor.


