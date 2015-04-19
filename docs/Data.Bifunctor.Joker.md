# Module Documentation

## Module Data.Bifunctor.Joker

#### `Joker`

``` purescript
data Joker g a b
  = Joker (g b)
```

Make a `Functor` over the second argument of a `Bifunctor`

#### `runJoker`

``` purescript
runJoker :: forall g a b. Joker g a b -> g b
```


#### `jokerBifunctor`

``` purescript
instance jokerBifunctor :: (Functor g) => Bifunctor (Joker g)
```


#### `jokerFunctor`

``` purescript
instance jokerFunctor :: (Functor g) => Functor (Joker g a)
```


#### `jokerBiapply`

``` purescript
instance jokerBiapply :: (Apply g) => Biapply (Joker g)
```


#### `jokerBiapplicative`

``` purescript
instance jokerBiapplicative :: (Applicative g) => Biapplicative (Joker g)
```




