module Data.Bifunctor.Joker where

import Data.Bifoldable
import Data.Bifunctor
import Data.Bitraversable
import Data.Foldable
import Data.Monoid
import Data.Traversable

import Control.Apply
import Control.Biapplicative
import Control.Biapply

data Joker g a b = Joker (g b)

runJoker :: forall g a b. Joker g a b -> g b
runJoker (Joker gb) = gb

instance jokerBifunctor :: (Functor g) => Bifunctor (Joker g) where
  bimap _ g = Joker <<< ((<$>) g) <<< runJoker

instance jokerFunctor :: (Functor g) => Functor (Joker g a) where
  (<$>) g = Joker <<< ((<$>) g) <<< runJoker

instance jokerBiapply :: (Apply g) => Biapply (Joker g) where
  (<<*>>) (Joker fg) (Joker xy) = Joker (fg <*> xy)

instance jokerBiapplicative :: (Applicative g) => Biapplicative (Joker g) where
  bipure _ b = Joker (pure b)

instance jokerBifoldable :: (Foldable g) => Bifoldable (Joker g) where
  bifoldr   _ g z = foldr   g z <<< runJoker
  bifoldl   _ g z = foldl   g z <<< runJoker
  bifoldMap _ g   = foldMap g   <<< runJoker

instance jokerFoldable :: (Foldable g) => Foldable (Joker g a) where
  foldr   g z = foldr   g z <<< runJoker
  foldl   g z = foldl   g z <<< runJoker
  foldMap g   = foldMap g   <<< runJoker

instance jokerBitraversable :: (Traversable g) => Bitraversable (Joker g) where
  bitraverse _ g = (<$>) Joker <<< traverse g <<< runJoker
  bisequence = bitraverse id id

instance jokerTraversable :: (Traversable g) => Traversable (Joker g a) where
  traverse g = (<$>) Joker <<< traverse g <<< runJoker
  sequence = traverse id
