module Data.Bifunctor.Clown where

import Prelude

import Control.Biapplicative
import Control.Biapply
import Data.Bifunctor

-- | Make a `Functor` over the first argument of a `Bifunctor`
data Clown f a b = Clown (f a)

runClown :: forall f a b. Clown f a b -> f a
runClown (Clown fa) = fa

instance clownBifunctor :: (Functor f) => Bifunctor (Clown f) where
  bimap f _ = Clown <<< map f <<< runClown

instance clownFunctor :: Functor (Clown f a) where
  map _ = Clown <<< runClown

instance clownBiapply :: (Apply f) => Biapply (Clown f) where
  biapply (Clown fg) (Clown xy) = Clown (fg <*> xy)

instance clownBiapplicative :: (Applicative f) => Biapplicative (Clown f) where
  bipure a _ = Clown (pure a)
