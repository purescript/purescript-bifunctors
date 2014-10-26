# Module Documentation

## Module Control.Biapplicative

### Type Classes

    class (Biapply w) <= Biapplicative w where
      bipure :: forall a b. a -> b -> w a b


### Type Class Instances

    instance biapplicativeConst :: Biapplicative Const

    instance biapplicativeTuple :: Biapplicative Tuple


## Module Control.Biapply

### Type Classes

    class (Bifunctor w) <= Biapply w where
      (<<*>>) :: forall a b c d. w (a -> b) (c -> d) -> w a c -> w b d


### Type Class Instances

    instance biapplyConst :: Biapply Const

    instance biapplyTuple :: Biapply Tuple


### Values

    (*>>) :: forall w a b c d. (Biapply w) => w a b -> w c d -> w c d

    (<<$>>) :: forall a b. (a -> b) -> a -> b

    (<<*) :: forall w a b c d. (Biapply w) => w a b -> w c d -> w a b

    bilift2 :: forall w a b c d e f. (Biapply w) => (a -> b -> c) -> (d -> e -> f) -> w a d -> w b e -> w c f

    bilift3 :: forall w a b c d e f g h. (Biapply w) => (a -> b -> c -> d) -> (e -> f -> g -> h) -> w a e -> w b f -> w c g -> w d h


## Module Data.Bifoldable

### Type Classes

    class Bifoldable p where
      bifoldr :: forall a b c. (a -> c -> c) -> (b -> c -> c) -> c -> p a b -> c
      bifoldl :: forall a b c. (c -> a -> c) -> (c -> b -> c) -> c -> p a b -> c
      bifoldMap :: forall m a b. (Monoid m) => (a -> m) -> (b -> m) -> p a b -> m


### Type Class Instances

    instance bifoldableConst :: Bifoldable Const

    instance bifoldableEither :: Bifoldable Either

    instance bifoldableTuple :: Bifoldable Tuple


### Values

    biall :: forall t a b. (Bifoldable t) => (a -> Boolean) -> (b -> Boolean) -> t a b -> Boolean

    biany :: forall t a b. (Bifoldable t) => (a -> Boolean) -> (b -> Boolean) -> t a b -> Boolean

    bifold :: forall t m. (Bifoldable t, Monoid m) => t m m -> m

    bifor_ :: forall t f a b c d. (Bifoldable t, Applicative f) => t a b -> (a -> f c) -> (b -> f d) -> f Unit

    bisequence_ :: forall t f a b. (Bifoldable t, Applicative f) => t (f a) (f b) -> f Unit

    bitraverse_ :: forall t f a b c d. (Bifoldable t, Applicative f) => (a -> f c) -> (b -> f d) -> t a b -> f Unit


## Module Data.Bifunctor

### Type Classes

    class Bifunctor f where
      bimap :: forall a b c d. (a -> b) -> (c -> d) -> f a c -> f b d


### Type Class Instances

    instance bifunctorConst :: Bifunctor Const

    instance bifunctorEither :: Bifunctor Either

    instance bifunctorTuple :: Bifunctor Tuple


### Values

    lmap :: forall f a b c. (Bifunctor f) => (a -> b) -> f a c -> f b c

    rmap :: forall f a b c. (Bifunctor f) => (b -> c) -> f a b -> f a c


## Module Data.Bifunctor.Clown

### Types

    data Clown f a b where
      Clown :: f a -> Clown f a b


### Type Class Instances

    instance clownBiapplicative :: (Applicative f) => Biapplicative (Clown f)

    instance clownBiapply :: (Apply f) => Biapply (Clown f)

    instance clownBifoldable :: (Foldable f) => Bifoldable (Clown f)

    instance clownBifunctor :: (Functor f) => Bifunctor (Clown f)

    instance clownBitraversable :: (Traversable f) => Bitraversable (Clown f)

    instance clownFoldable :: Foldable (Clown f a)

    instance clownFunctor :: Functor (Clown f a)

    instance clownTraversable :: Traversable (Clown f a)


### Values

    runClown :: forall f a b. Clown f a b -> f a


## Module Data.Bifunctor.Flip

### Types

    data Flip p a b where
      Flip :: p b a -> Flip p a b


### Type Class Instances

    instance flipBiapplicative :: (Biapplicative p) => Biapplicative (Flip p)

    instance flipBiapply :: (Biapply p) => Biapply (Flip p)

    instance flipBifoldable :: (Bifoldable p) => Bifoldable (Flip p)

    instance flipBifunctor :: (Bifunctor p) => Bifunctor (Flip p)

    instance flipBitraversable :: (Bitraversable p) => Bitraversable (Flip p)

    instance flipFoldable :: (Bifoldable p) => Foldable (Flip p a)

    instance flipFunctor :: (Bifunctor p) => Functor (Flip p a)

    instance flipTraversable :: (Bitraversable p) => Traversable (Flip p a)


### Values

    runFlip :: forall p a b. Flip p a b -> p b a


## Module Data.Bifunctor.Join

### Types

    data Join p a where
      Join :: p a a -> Join p a


### Type Class Instances

    instance joinApplicative :: (Biapplicative p) => Applicative (Join p)

    instance joinApply :: (Biapply p) => Apply (Join p)

    instance joinFoldable :: (Bifoldable p) => Foldable (Join p)

    instance joinFunctor :: (Bifunctor p) => Functor (Join p)

    instance joinTraversable :: (Bitraversable p) => Traversable (Join p)


### Values

    runJoin :: forall p a. Join p a -> p a a


## Module Data.Bifunctor.Joker

### Types

    data Joker g a b where
      Joker :: g b -> Joker g a b


### Type Class Instances

    instance jokerBiapplicative :: (Applicative g) => Biapplicative (Joker g)

    instance jokerBiapply :: (Apply g) => Biapply (Joker g)

    instance jokerBifoldable :: (Foldable g) => Bifoldable (Joker g)

    instance jokerBifunctor :: (Functor g) => Bifunctor (Joker g)

    instance jokerBitraversable :: (Traversable g) => Bitraversable (Joker g)

    instance jokerFoldable :: (Foldable g) => Foldable (Joker g a)

    instance jokerFunctor :: (Functor g) => Functor (Joker g a)

    instance jokerTraversable :: (Traversable g) => Traversable (Joker g a)


### Values

    runJoker :: forall g a b. Joker g a b -> g b


## Module Data.Bifunctor.Product

### Types

    data Product f g a b where
      Pair :: f a b -> g a b -> Product f g a b


### Type Class Instances

    instance productBiapplicative :: (Biapplicative f, Biapplicative g) => Biapplicative (Product f g)

    instance productBiapply :: (Biapply f, Biapply g) => Biapply (Product f g)

    instance productBifoldable :: (Bifoldable f, Bifoldable g) => Bifoldable (Product f g)

    instance productBifunctor :: (Bifunctor f, Bifunctor g) => Bifunctor (Product f g)

    instance productBitraversable :: (Bitraversable f, Bitraversable g) => Bitraversable (Product f g)


## Module Data.Bifunctor.Wrap

### Types

    data Wrap p a b where
      Wrap :: p a b -> Wrap p a b


### Type Class Instances

    instance wrapBiapplicative :: (Biapplicative p) => Biapplicative (Wrap p)

    instance wrapBiapply :: (Biapply p) => Biapply (Wrap p)

    instance wrapBifoldable :: (Bifoldable p) => Bifoldable (Wrap p)

    instance wrapBifunctor :: (Bifunctor p) => Bifunctor (Wrap p)

    instance wrapBitraversable :: (Bitraversable p) => Bitraversable (Wrap p)

    instance wrapFoldable :: (Bifoldable p) => Foldable (Wrap p a)

    instance wrapFunctor :: (Bifunctor p) => Functor (Wrap p a)

    instance wrapTraversable :: (Bitraversable p) => Traversable (Wrap p a)


### Values

    unwrap :: forall p a b. Wrap p a b -> p a b


## Module Data.Bitraversable

### Type Classes

    class (Bifunctor t, Bifoldable t) <= Bitraversable t where
      bitraverse :: forall f a b c d. (Applicative f) => (a -> f c) -> (b -> f d) -> t a b -> f (t c d)
      bisequence :: forall f a b. (Applicative f) => t (f a) (f b) -> f (t a b)


### Type Class Instances

    instance bitraversableConst :: Bitraversable Const

    instance bitraversableEither :: Bitraversable Either

    instance bitraversableTuple :: Bitraversable Tuple


### Values

    bifor :: forall t f a b c d. (Bitraversable t, Applicative f) => t a b -> (a -> f c) -> (b -> f d) -> f (t c d)