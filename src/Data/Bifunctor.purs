module Data.Bifunctor where

import Data.Either
import Data.Tuple

class Bifunctor f where
  bimap :: forall a b c d. (a -> b) -> (c -> d) -> f a c -> f b d

lmap :: forall f a b c. (Bifunctor f) => (a -> b) -> f a c -> f b c
lmap f = bimap f id

rmap :: forall f a b c. (Bifunctor f) => (b -> c) -> f a b -> f a c
rmap = bimap id

instance bifunctorEither :: Bifunctor Either where
  bimap f _ (Left l) = Left (f l)
  bimap _ g (Right r) = Right (g r)
  
instance bifunctorTuple :: Bifunctor Tuple where
  bimap f g (Tuple x y) = Tuple (f x) (g y)
