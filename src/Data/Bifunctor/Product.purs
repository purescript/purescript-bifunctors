module Data.Bifunctor.Product where

import Data.Bifoldable
import Data.Bifunctor
import Data.Bitraversable
import Data.Foldable
import Data.Monoid
import Data.Monoid.Dual
import Data.Monoid.Endo
import Data.Traversable

import Control.Apply
import Control.Biapplicative
import Control.Biapply

-- | The product of two `Bifunctor`s.
data Product f g a b = Pair (f a b) (g a b)

instance productBifunctor :: (Bifunctor f, Bifunctor g) => Bifunctor (Product f g) where
  bimap f g (Pair x y) = Pair (bimap f g x) (bimap f g y)

instance productBiapply :: (Biapply f, Biapply g) => Biapply (Product f g) where
  (<<*>>) (Pair w x) (Pair y z) = Pair (w <<*>> y) (x <<*>> z)

instance productBiapplicative :: (Biapplicative f, Biapplicative g) => Biapplicative (Product f g) where
  bipure a b = Pair (bipure a b) (bipure a b)

-- todo: simplify bifoldr/bifoldl a little bit
instance productBifoldable :: (Bifoldable f, Bifoldable g) => Bifoldable (Product f g) where
  bifoldr f g z p = runEndo (bifoldMap (Endo <<< f) (Endo <<< g) p) z
  bifoldl f g z p = runEndo (runDual (bifoldMap (Dual <<< Endo <<< flip f) (Dual <<< Endo <<< flip g) p)) z
  bifoldMap f g (Pair x y) = bifoldMap f g x <> bifoldMap f g y

instance productBitraversable :: (Bitraversable f, Bitraversable g) => Bitraversable (Product f g) where
  bitraverse f g (Pair x y) = Pair <$> bitraverse f g x <*> bitraverse f g y
  bisequence = bitraverse id id
