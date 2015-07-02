## Module Data.Bifunctor.Joker

#### `Joker`

``` purescript
data Joker g a b
  = Joker (g b)
```

Make a `Functor` over the second argument of a `Bifunctor`

##### Instances
``` purescript
instance jokerBifunctor :: (Functor g) => Bifunctor (Joker g)
instance jokerFunctor :: (Functor g) => Functor (Joker g a)
instance jokerBiapply :: (Apply g) => Biapply (Joker g)
instance jokerBiapplicative :: (Applicative g) => Biapplicative (Joker g)
```

#### `runJoker`

``` purescript
runJoker :: forall g a b. Joker g a b -> g b
```


