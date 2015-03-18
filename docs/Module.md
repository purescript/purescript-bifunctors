# Module Documentation

## Module Control.Biapplicative

#### `Biapplicative`

``` purescript
class (Biapply w) <= Biapplicative w where
  bipure :: forall a b. a -> b -> w a b
```

`Biapplicative` captures type constructors of two arguments which support lifting of
functions of zero or more arguments, in the sense of `Applicative`.

#### `biapplicativeTuple`

``` purescript
instance biapplicativeTuple :: Biapplicative Tuple
```


#### `biapplicativeConst`

``` purescript
instance biapplicativeConst :: Biapplicative Const
```



## Module Control.Biapply

#### `(<<$>>)`

``` purescript
(<<$>>) :: forall a b. (a -> b) -> a -> b
```

A convenience function which can be used to apply the result of `bipure` in
the style of `Applicative`:

```purescript
bipure f g <<$>> x <<*>> y
```

#### `Biapply`

``` purescript
class (Bifunctor w) <= Biapply w where
  (<<*>>) :: forall a b c d. w (a -> b) (c -> d) -> w a c -> w b d
```

`Biapply` captures type constructors of two arguments which support lifting of
functions of one or more arguments, in the sense of `Apply`.

#### `(*>>)`

``` purescript
(*>>) :: forall w a b c d. (Biapply w) => w a b -> w c d -> w c d
```

Keep the results of the second computation

#### `(<<*)`

``` purescript
(<<*) :: forall w a b c d. (Biapply w) => w a b -> w c d -> w a b
```

Keep the results of the first computation

#### `bilift2`

``` purescript
bilift2 :: forall w a b c d e f. (Biapply w) => (a -> b -> c) -> (d -> e -> f) -> w a d -> w b e -> w c f
```

Lift a function of two arguments.

#### `bilift3`

``` purescript
bilift3 :: forall w a b c d e f g h. (Biapply w) => (a -> b -> c -> d) -> (e -> f -> g -> h) -> w a e -> w b f -> w c g -> w d h
```

Lift a function of three arguments.

#### `biapplyTuple`

``` purescript
instance biapplyTuple :: Biapply Tuple
```


#### `biapplyConst`

``` purescript
instance biapplyConst :: Biapply Const
```



## Module Data.Bifoldable

#### `Bifoldable`

``` purescript
class Bifoldable p where
  bifoldr :: forall a b c. (a -> c -> c) -> (b -> c -> c) -> c -> p a b -> c
  bifoldl :: forall a b c. (c -> a -> c) -> (c -> b -> c) -> c -> p a b -> c
  bifoldMap :: forall m a b. (Monoid m) => (a -> m) -> (b -> m) -> p a b -> m
```

`Bifoldable` represents data structures with two type arguments which can be 
folded.

A fold for such a structure requires two step functions, one for each type 
argument. Type class instances should choose the appropriate step function based
on the type of the element encountered at each point of the fold.


#### `bifoldableTuple`

``` purescript
instance bifoldableTuple :: Bifoldable Tuple
```


#### `bifoldableEither`

``` purescript
instance bifoldableEither :: Bifoldable Either
```


#### `bifoldableConst`

``` purescript
instance bifoldableConst :: Bifoldable Const
```


#### `bifold`

``` purescript
bifold :: forall t m. (Bifoldable t, Monoid m) => t m m -> m
```

Fold a data structure, accumulating values in a monoidal type.

#### `bitraverse_`

``` purescript
bitraverse_ :: forall t f a b c d. (Bifoldable t, Applicative f) => (a -> f c) -> (b -> f d) -> t a b -> f Unit
```

Traverse a data structure, accumulating effects using an `Applicative` functor,
ignoring the final result.

#### `bifor_`

``` purescript
bifor_ :: forall t f a b c d. (Bifoldable t, Applicative f) => t a b -> (a -> f c) -> (b -> f d) -> f Unit
```

A version of `bitraverse_` with the data structure as the first argument.

#### `bisequence_`

``` purescript
bisequence_ :: forall t f a b. (Bifoldable t, Applicative f) => t (f a) (f b) -> f Unit
```

Collapse a data structure, collecting effects using an `Applicative` functor,
ignoring the final result.

#### `biany`

``` purescript
biany :: forall t a b. (Bifoldable t) => (a -> Boolean) -> (b -> Boolean) -> t a b -> Boolean
```

Test whether a predicate holds at any position in a data structure.

#### `biall`

``` purescript
biall :: forall t a b. (Bifoldable t) => (a -> Boolean) -> (b -> Boolean) -> t a b -> Boolean
```

Test whether a predicate holds at all positions in a data structure.


## Module Data.Bifunctor

#### `Bifunctor`

``` purescript
class Bifunctor f where
  bimap :: forall a b c d. (a -> b) -> (c -> d) -> f a c -> f b d
```

A `Bifunctor` is a `Functor` from the pair category `(Type, Type)` to `Type`.

A type constructor with two type arguments can be made into a `Bifunctor` if
both of its type arguments are covariant.

The `bimap` function maps a pair of functions over the two type arguments
of the bifunctor.

Laws:

- Identity: `bimap id id == id`
- Composition: `bimap f1 g1 <<< bimap f2 g2 == bimap (f1 <<< f2) (g1 <<< g2)`


#### `lmap`

``` purescript
lmap :: forall f a b c. (Bifunctor f) => (a -> b) -> f a c -> f b c
```

Map a function over the first type argument of a `Bifunctor`.

#### `rmap`

``` purescript
rmap :: forall f a b c. (Bifunctor f) => (b -> c) -> f a b -> f a c
```

Map a function over the second type component of a `Bifunctor`.

#### `bifunctorEither`

``` purescript
instance bifunctorEither :: Bifunctor Either
```


#### `bifunctorTuple`

``` purescript
instance bifunctorTuple :: Bifunctor Tuple
```


#### `bifunctorConst`

``` purescript
instance bifunctorConst :: Bifunctor Const
```



## Module Data.Bifunctor.Clown

#### `Clown`

``` purescript
data Clown f a b
  = Clown (f a)
```


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


#### `clownBifoldable`

``` purescript
instance clownBifoldable :: (Foldable f) => Bifoldable (Clown f)
```


#### `clownFoldable`

``` purescript
instance clownFoldable :: Foldable (Clown f a)
```


#### `clownBitraversable`

``` purescript
instance clownBitraversable :: (Traversable f) => Bitraversable (Clown f)
```


#### `clownTraversable`

``` purescript
instance clownTraversable :: Traversable (Clown f a)
```



## Module Data.Bifunctor.Flip

#### `Flip`

``` purescript
data Flip p a b
  = Flip (p b a)
```

Flips the order of the type arguments of a `Bifunctor`, creating a
`Functor` instance for the first type argument.

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


#### `flipBifoldable`

``` purescript
instance flipBifoldable :: (Bifoldable p) => Bifoldable (Flip p)
```


#### `flipFoldable`

``` purescript
instance flipFoldable :: (Bifoldable p) => Foldable (Flip p a)
```


#### `flipBitraversable`

``` purescript
instance flipBitraversable :: (Bitraversable p) => Bitraversable (Flip p)
```


#### `flipTraversable`

``` purescript
instance flipTraversable :: (Bitraversable p) => Traversable (Flip p a)
```



## Module Data.Bifunctor.Join

#### `Join`

``` purescript
data Join p a
  = Join (p a a)
```

`Join` turns a `Bifunctor` into a `Functor` by equating the
two type arguments.

#### `runJoin`

``` purescript
runJoin :: forall p a. Join p a -> p a a
```

Remove the `Join` constructor.

#### `joinFunctor`

``` purescript
instance joinFunctor :: (Bifunctor p) => Functor (Join p)
```


#### `joinApply`

``` purescript
instance joinApply :: (Biapply p) => Apply (Join p)
```


#### `joinApplicative`

``` purescript
instance joinApplicative :: (Biapplicative p) => Applicative (Join p)
```


#### `joinFoldable`

``` purescript
instance joinFoldable :: (Bifoldable p) => Foldable (Join p)
```


#### `joinTraversable`

``` purescript
instance joinTraversable :: (Bitraversable p) => Traversable (Join p)
```



## Module Data.Bifunctor.Joker

#### `Joker`

``` purescript
data Joker g a b
  = Joker (g b)
```


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


#### `jokerBifoldable`

``` purescript
instance jokerBifoldable :: (Foldable g) => Bifoldable (Joker g)
```


#### `jokerFoldable`

``` purescript
instance jokerFoldable :: (Foldable g) => Foldable (Joker g a)
```


#### `jokerBitraversable`

``` purescript
instance jokerBitraversable :: (Traversable g) => Bitraversable (Joker g)
```


#### `jokerTraversable`

``` purescript
instance jokerTraversable :: (Traversable g) => Traversable (Joker g a)
```



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


#### `productBifoldable`

``` purescript
instance productBifoldable :: (Bifoldable f, Bifoldable g) => Bifoldable (Product f g)
```

#### `productBitraversable`

``` purescript
instance productBitraversable :: (Bitraversable f, Bitraversable g) => Bitraversable (Product f g)
```



## Module Data.Bifunctor.Wrap

#### `Wrap`

``` purescript
data Wrap p a b
  = Wrap (p a b)
```

A `newtype` wrapper which provides default `Functor`, `Foldable` and `Traversable`
type class instances for `Bifunctor`s.

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


#### `wrapBifoldable`

``` purescript
instance wrapBifoldable :: (Bifoldable p) => Bifoldable (Wrap p)
```


#### `wrapFoldable`

``` purescript
instance wrapFoldable :: (Bifoldable p) => Foldable (Wrap p a)
```


#### `wrapBitraversable`

``` purescript
instance wrapBitraversable :: (Bitraversable p) => Bitraversable (Wrap p)
```


#### `wrapTraversable`

``` purescript
instance wrapTraversable :: (Bitraversable p) => Traversable (Wrap p a)
```



## Module Data.Bitraversable

#### `Bitraversable`

``` purescript
class (Bifunctor t, Bifoldable t) <= Bitraversable t where
  bitraverse :: forall f a b c d. (Applicative f) => (a -> f c) -> (b -> f d) -> t a b -> f (t c d)
  bisequence :: forall f a b. (Applicative f) => t (f a) (f b) -> f (t a b)
```

`Bitraversable` represents data structures with two type arguments which can be 
traversed.

A traversal for such a structure requires two functions, one for each type 
argument. Type class instances should choose the appropriate function based
on the type of the element encountered at each point of the traversal.


#### `bitraversableTuple`

``` purescript
instance bitraversableTuple :: Bitraversable Tuple
```


#### `bitraversableEither`

``` purescript
instance bitraversableEither :: Bitraversable Either
```


#### `bitraversableConst`

``` purescript
instance bitraversableConst :: Bitraversable Const
```


#### `bifor`

``` purescript
bifor :: forall t f a b c d. (Bitraversable t, Applicative f) => t a b -> (a -> f c) -> (b -> f d) -> f (t c d)
```

Traverse a data structure, accumulating effects and results using an `Applicative` functor.