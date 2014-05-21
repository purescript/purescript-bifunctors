# Module Documentation

## Module Control.Biapplicative

### Type Classes

    class (Biapply w) <= Biapplicative w where
      bipure :: forall a b. a -> b -> w a b


### Type Class Instances

    instance biapplicativeTuple :: Biapplicative Tuple


## Module Control.Biapply

### Type Classes

    class (Bifunctor w) <= Biapply w where
      (<<*>>) :: forall a b c d. w (a -> b) (c -> d) -> w a c -> w b d


### Type Class Instances

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

    instance bifoldableEither :: Bifoldable Either

    instance bifoldableTuple :: Bifoldable Tuple


### Values

    biall :: forall t a b. (Bifoldable t) => (a -> Prim.Boolean) -> (b -> Prim.Boolean) -> t a b -> Prim.Boolean

    biany :: forall t a b. (Bifoldable t) => (a -> Prim.Boolean) -> (b -> Prim.Boolean) -> t a b -> Prim.Boolean

    bifold :: forall t m. (Bifoldable t, Monoid m) => t m m -> m

    bifor_ :: forall t f a b c d. (Bifoldable t, Applicative f) => t a b -> (a -> f c) -> (b -> f d) -> f Unit

    bisequence_ :: forall t f a b. (Bifoldable t, Applicative f) => t (f a) (f b) -> f Unit

    bitraverse_ :: forall t f a b c d. (Bifoldable t, Applicative f) => (a -> f c) -> (b -> f d) -> t a b -> f Unit


## Module Data.Bifunctor

### Type Classes

    class Bifunctor f where
      bimap :: forall a b c d. (a -> b) -> (c -> d) -> f a c -> f b d


### Type Class Instances

    instance bifunctorEither :: Bifunctor Either

    instance bifunctorTuple :: Bifunctor Tuple


### Values

    lmap :: forall f a b c. (Bifunctor f) => (a -> b) -> f a c -> f b c

    rmap :: forall f a b c. (Bifunctor f) => (b -> c) -> f a b -> f a c


## Module Data.Bitraversable

### Type Classes

    class (Bifunctor t, Bifoldable t) <= Bitraversable t where
      bitraverse :: forall f a b c d. (Applicative f) => (a -> f c) -> (b -> f d) -> t a b -> f (t c d)
      bisequence :: forall f a b. (Applicative f) => t (f a) (f b) -> f (t a b)


### Type Class Instances

    instance bitraversableEither :: Bitraversable Either

    instance bitraversableTuple :: Bitraversable Tuple


### Values

    bifor :: forall t f a b c d. (Bitraversable t, Applicative f) => t a b -> (a -> f c) -> (b -> f d) -> f (t c d)