module Data.Bifunctor.Join where

import Prelude

import Control.Biapplicative
import Control.Biapply
import Data.Bifunctor

-- | `Join` turns a `Bifunctor` into a `Functor` by equating the
-- | two type arguments.
data Join p a = Join (p a a)

-- | Remove the `Join` constructor.
runJoin :: forall p a. Join p a -> p a a
runJoin (Join paa) = paa

instance joinFunctor :: (Bifunctor p) => Functor (Join p) where
  map f = Join <$> bimap f f <<< runJoin

instance joinApply :: (Biapply p) => Apply (Join p) where
  apply (Join f) (Join a) = Join (f <<*>> a)

instance joinApplicative :: (Biapplicative p) => Applicative (Join p) where
  pure a = Join (bipure a a)
