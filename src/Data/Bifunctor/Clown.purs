module Data.Bifunctor.Clown where

import Data.Bifoldable
import Data.Bifunctor
import Data.Bitraversable
import Data.Foldable
import Data.Monoid
import Data.Traversable

import Control.Apply
import Control.Biapplicative
import Control.Biapply

data Clown f a b = Clown (f a)

runClown :: forall f a b. Clown f a b -> f a
runClown (Clown fa) = fa

instance clownBifunctor :: (Functor f) => Bifunctor (Clown f) where
  bimap f _ = Clown <<< ((<$>) f) <<< runClown

instance clownFunctor :: Functor (Clown f a) where
  (<$>) _ = Clown <<< runClown

instance clownBiapply :: (Apply f) => Biapply (Clown f) where
  (<<*>>) (Clown fg) (Clown xy) = Clown (fg <*> xy)

instance clownBiapplicative :: (Applicative f) => Biapplicative (Clown f) where
  bipure a _ = Clown (pure a)

instance clownBifoldable :: (Foldable f) => Bifoldable (Clown f) where
  bifoldr   f _ z = foldr   f z <<< runClown
  bifoldl   f _ z = foldl   f z <<< runClown
  bifoldMap f _   = foldMap f   <<< runClown

instance clownFoldable :: Foldable (Clown f a) where
  foldr   _ z = const z
  foldl   _ z = const z
  foldMap _ _ = mempty

instance clownBitraversable :: (Traversable f) => Bitraversable (Clown f) where
  bitraverse f _ = (<$>) Clown <<< traverse f <<< runClown
  bisequence = bitraverse id id

instance clownTraversable :: Traversable (Clown f a) where
  traverse _ = pure <<< Clown <<< runClown
  sequence = traverse id
