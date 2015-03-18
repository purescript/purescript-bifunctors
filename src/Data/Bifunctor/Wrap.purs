module Data.Bifunctor.Wrap where

import Data.Bifoldable
import Data.Bifunctor
import Data.Bitraversable
import Data.Foldable
import Data.Monoid
import Data.Traversable

import Control.Apply
import Control.Biapplicative
import Control.Biapply

-- | A `newtype` wrapper which provides default `Functor`, `Foldable` and `Traversable`
-- | type class instances for `Bifunctor`s.
data Wrap p a b = Wrap (p a b)

-- | Remove the `Wrap` constructor.
unwrap :: forall p a b. Wrap p a b -> p a b
unwrap (Wrap pab) = pab

instance wrapBifunctor :: (Bifunctor p) => Bifunctor (Wrap p) where
  bimap f g = Wrap <<< (bimap f g) <<< unwrap

instance wrapFunctor :: (Bifunctor p) => Functor (Wrap p a) where
  (<$>) f = Wrap <<< rmap f <<< unwrap

instance wrapBiapply :: (Biapply p) => Biapply (Wrap p) where
  (<<*>>) (Wrap fg) (Wrap xy) = Wrap (fg <<*>> xy)

instance wrapBiapplicative :: (Biapplicative p) => Biapplicative (Wrap p) where
  bipure a b = Wrap (bipure a b)

instance wrapBifoldable :: (Bifoldable p) => Bifoldable (Wrap p) where
  bifoldr   f g z = bifoldr f g z <<< unwrap
  bifoldl   f g z = bifoldl f g z <<< unwrap
  bifoldMap f g   = bifoldMap f g <<< unwrap

instance wrapFoldable :: (Bifoldable p) => Foldable (Wrap p a) where
  foldr   f z = bifoldr   (flip const)   f z <<< unwrap
  foldl   f z = bifoldl    const         f z <<< unwrap
  foldMap f   = bifoldMap (const mempty) f   <<< unwrap

instance wrapBitraversable :: (Bitraversable p) => Bitraversable (Wrap p) where
  bitraverse f g = (<$>) Wrap <<< bitraverse f g <<< unwrap
  bisequence = bitraverse id id

instance wrapTraversable :: (Bitraversable p) => Traversable (Wrap p a) where
  traverse f = (<$>) Wrap <<< bitraverse pure f <<< unwrap
  sequence = traverse id
