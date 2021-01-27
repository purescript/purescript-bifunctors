module Data.Bifunctor where

import Data.Functor (class Functor, map)
import Data.Functor.Clown (Clown(..))
import Data.Functor.Joker (Joker(..))
import Data.Functor.Product2 (Product2(..))
import Control.Biapplicative (class Biapplicative, bipure)
import Control.Biapply (class Biapply, biapply)
import Control.Category (identity)

-- | A `Bifunctor` is a `Functor` from the pair category `(Type, Type)` to `Type`.
-- |
-- | A type constructor with two type arguments can be made into a `Bifunctor` if
-- | both of its type arguments are covariant.
-- |
-- | The `bimap` function maps a pair of functions over the two type arguments
-- | of the bifunctor.
-- |
-- | Laws:
-- |
-- | - Identity: `bimap identity identity == identity`
-- | - Composition: `bimap f1 g1 <<< bimap f2 g2 == bimap (f1 <<< f2) (g1 <<< g2)`
-- |
class Bifunctor f where
  bimap :: forall a b c d. (a -> b) -> (c -> d) -> f a c -> f b d

instance bifunctorClown :: Functor f => Bifunctor (Clown f) where
  bimap f _ (Clown a) = Clown (map f a)

instance bifunctorJoker :: Functor g => Bifunctor (Joker g) where
  bimap _ g (Joker a) = Joker (map g a)

instance bifunctorProduct2 :: (Bifunctor f, Bifunctor g) => Bifunctor (Product2 f g) where
  bimap f g (Product2 x y) = Product2 (bimap f g x) (bimap f g y)

-- | Map a function over the first type argument of a `Bifunctor`.
lmap :: forall f a b c. Bifunctor f => (a -> b) -> f a c -> f b c
lmap f = bimap f identity

-- | Map a function over the second type arguments of a `Bifunctor`.
rmap :: forall f a b c. Bifunctor f => (b -> c) -> f a b -> f a c
rmap = bimap identity
