# Module Documentation

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