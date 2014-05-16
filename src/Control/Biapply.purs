module Control.Biapply where

import Control.Apply
import Data.Bifunctor
import Data.Tuple

infixl 4 <<$>>
infixl 4 <<*>>
infixl 4 <<*
infixl 4 *>>

(<<$>>) :: forall a b. (a -> b) -> a -> b
(<<$>>) = id

class (Bifunctor w) <= Biapply w where
  (<<*>>) :: forall a b c d. w (a -> b) (c -> d) -> w a c -> w b d

(*>>) :: forall w a b c d. (Biapply w) => w a b -> w c d -> w c d
(*>>) a b = bimap (const id) (const id) <<$>> a <<*>> b

(<<*) :: forall w a b c d. (Biapply w) => w a b -> w c d -> w a b
(<<*) a b = bimap const const <<$>> a <<*>> b

bilift2 :: forall w a b c d e f. (Biapply w) => (a -> b -> c) -> (d -> e -> f) -> w a d -> w b e -> w c f
bilift2 f g a b = bimap f g <<$>> a <<*>> b

bilift3 :: forall w a b c d e f g h. (Biapply w) => (a -> b -> c -> d) -> (e -> f -> g -> h) -> w a e -> w b f -> w c g -> w d h
bilift3 f g a b c = bimap f g <<$>> a <<*>> b <<*>> c

instance biapplyTuple :: Biapply Tuple where
  (<<*>>) (Tuple f g) (Tuple a b) = Tuple (f a) (g b)
