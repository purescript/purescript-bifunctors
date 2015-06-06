module Data.Bifunctor.Product where

import Prelude

import Control.Biapplicative
import Control.Biapply
import Data.Bifunctor

-- | The product of two `Bifunctor`s.
data Product f g a b = Pair (f a b) (g a b)

instance productBifunctor :: (Bifunctor f, Bifunctor g) => Bifunctor (Product f g) where
  bimap f g (Pair x y) = Pair (bimap f g x) (bimap f g y)

instance productBiapply :: (Biapply f, Biapply g) => Biapply (Product f g) where
  biapply (Pair w x) (Pair y z) = Pair (biapply w y) (biapply x z)

instance productBiapplicative :: (Biapplicative f, Biapplicative g) => Biapplicative (Product f g) where
  bipure a b = Pair (bipure a b) (bipure a b)
