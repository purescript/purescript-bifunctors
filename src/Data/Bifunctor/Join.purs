module Data.Bifunctor.Join where

import Data.Bifoldable
import Data.Bifunctor
import Data.Bitraversable
import Data.Foldable
import Data.Traversable
import Data.Monoid
import Control.Apply
import Control.Biapply
-- Applicative is in Prelude
import Control.Biapplicative

data Join p a = Join (p a a)

runJoin :: forall p a. Join p a -> p a a
runJoin (Join paa) = paa

instance joinFunctor :: (Bifunctor p) => Functor (Join p) where
  (<$>) f = Join <$> bimap f f <<< runJoin

instance joinApply :: (Biapply p) => Apply (Join p) where
  (<*>) (Join f) (Join a) = Join (f <<*>> a)

instance joinApplicative :: (Biapplicative p) => Applicative (Join p) where
  pure a = Join (bipure a a)

instance joinFoldable :: (Bifoldable p) => Foldable (Join p) where
  foldr   f z = bifoldr   f f z <<< runJoin
  foldl   f z = bifoldl   f f z <<< runJoin
  foldMap f   = bifoldMap f f   <<< runJoin

instance joinTraversable :: (Bitraversable p) => Traversable (Join p) where
  traverse f (Join a) = Join <$> bitraverse f f a
  sequence = traverse id
