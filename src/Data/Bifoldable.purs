module Data.Bifoldable where

import Control.Apply
import Control.Bind
import Data.Either
import Data.Monoid
import Data.Monoid.Any
import Data.Monoid.All
import Data.Tuple

class Bifoldable p where
  bifoldr :: forall a b c. (a -> c -> c) -> (b -> c -> c) -> c -> p a b -> c
  bifoldl :: forall a b c. (c -> a -> c) -> (c -> b -> c) -> c -> p a b -> c
  bifoldMap :: forall m a b. (Monoid m) => (a -> m) -> (b -> m) -> p a b -> m
  
instance bifoldableTuple :: Bifoldable Tuple where
  bifoldMap f g (Tuple a b) = f a <> g b
  bifoldr f g z (Tuple a b) = f a (g b z)
  bifoldl f g z (Tuple a b) = g (f z a) b 

instance bifoldableEither :: Bifoldable Either where
  bifoldMap f _ (Left a) = f a
  bifoldMap _ g (Right b) = g b
  bifoldr f _ z (Left a) = f a z
  bifoldr _ g z (Right b) = g b z
  bifoldl f _ z (Left a) = f z a
  bifoldl _ g z (Right b) = g z b
  
bifold :: forall t m. (Bifoldable t, Monoid m) => t m m -> m
bifold = bifoldMap id id  

bitraverse_ :: forall t f a b c d. (Bifoldable t, Applicative f) => (a -> f c) -> (b -> f d) -> t a b -> f Unit
bitraverse_ f g = bifoldr ((*>) <<< f) ((*>) <<< g) (pure unit)

bifor_ :: forall t f a b c d. (Bifoldable t, Applicative f) => t a b -> (a -> f c) -> (b -> f d) -> f Unit
bifor_ t f g = bitraverse_ f g t

bisequence_ :: forall t f a b. (Bifoldable t, Applicative f) => t (f a) (f b) -> f Unit
bisequence_ = bitraverse_ id id

biany :: forall t a b. (Bifoldable t) => (a -> Boolean) -> (b -> Boolean) -> t a b -> Boolean
biany p q = runAny <<< bifoldMap (Any <<< p) (Any <<< q)

biall :: forall t a b. (Bifoldable t) => (a -> Boolean) -> (b -> Boolean) -> t a b -> Boolean
biall p q = runAll <<< bifoldMap (All <<< p) (All <<< q)
