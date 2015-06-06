module Data.Bifunctor.Joker where

import Prelude

import Control.Biapplicative
import Control.Biapply
import Data.Bifunctor

-- | Make a `Functor` over the second argument of a `Bifunctor`
data Joker g a b = Joker (g b)

runJoker :: forall g a b. Joker g a b -> g b
runJoker (Joker gb) = gb

instance jokerBifunctor :: (Functor g) => Bifunctor (Joker g) where
  bimap _ g = Joker <<< map g <<< runJoker

instance jokerFunctor :: (Functor g) => Functor (Joker g a) where
  map g = Joker <<< map g <<< runJoker

instance jokerBiapply :: (Apply g) => Biapply (Joker g) where
  biapply (Joker fg) (Joker xy) = Joker (fg <*> xy)

instance jokerBiapplicative :: (Applicative g) => Biapplicative (Joker g) where
  bipure _ b = Joker (pure b)
