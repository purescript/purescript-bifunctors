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