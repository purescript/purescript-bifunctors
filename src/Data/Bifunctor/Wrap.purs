module Data.Bifunctor.Wrap where

import Prelude

import Control.Biapplicative
import Control.Biapply
import Data.Bifunctor

-- | A `newtype` wrapper which provides a `Functor` over the second argument of
-- | a `Bifunctor`
data Wrap p a b = Wrap (p a b)

-- | Remove the `Wrap` constructor.
unwrap :: forall p a b. Wrap p a b -> p a b
unwrap (Wrap pab) = pab

instance wrapBifunctor :: (Bifunctor p) => Bifunctor (Wrap p) where
  bimap f g = Wrap <<< bimap f g <<< unwrap

instance wrapFunctor :: (Bifunctor p) => Functor (Wrap p a) where
  map f = Wrap <<< rmap f <<< unwrap

instance wrapBiapply :: (Biapply p) => Biapply (Wrap p) where
  biapply (Wrap fg) (Wrap xy) = Wrap (fg <<*>> xy)

instance wrapBiapplicative :: (Biapplicative p) => Biapplicative (Wrap p) where
  bipure a b = Wrap (bipure a b)
