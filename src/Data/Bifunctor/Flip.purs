module Data.Bifunctor.Flip where

import Prelude

import Control.Biapplicative
import Control.Biapply
import Data.Bifunctor

-- | Flips the order of the type arguments of a `Bifunctor`.
data Flip p a b = Flip (p b a)

-- | Remove the `Flip` constructor.
runFlip :: forall p a b. Flip p a b -> p b a
runFlip (Flip pba) = pba

instance flipBifunctor :: (Bifunctor p) => Bifunctor (Flip p) where
  bimap f g = Flip <<< bimap g f <<< runFlip

instance flipFunctor :: (Bifunctor p) => Functor (Flip p a) where
  map f = Flip <<< lmap f <<< runFlip

instance flipBiapply :: (Biapply p) => Biapply (Flip p) where
  biapply (Flip fg) (Flip xy) = Flip (fg <<*>> xy)

instance flipBiapplicative :: (Biapplicative p) => Biapplicative (Flip p) where
  bipure a b = Flip (bipure b a)
