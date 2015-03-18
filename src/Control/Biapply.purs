module Control.Biapply where

import Data.Bifunctor
import Data.Const
import Data.Tuple

import Control.Apply

infixl 4 <<$>>
infixl 4 <<*>>
infixl 4 <<*
infixl 4 *>>

-- | A convenience function which can be used to apply the result of `bipure` in
-- | the style of `Applicative`:
-- |
-- | ```purescript
-- | bipure f g <<$>> x <<*>> y
-- | ```
(<<$>>) :: forall a b. (a -> b) -> a -> b
(<<$>>) = id

-- | `Biapply` captures type constructors of two arguments which support lifting of
-- | functions of one or more arguments, in the sense of `Apply`.
class (Bifunctor w) <= Biapply w where
  (<<*>>) :: forall a b c d. w (a -> b) (c -> d) -> w a c -> w b d

-- | Keep the results of the second computation
(*>>) :: forall w a b c d. (Biapply w) => w a b -> w c d -> w c d
(*>>) a b = bimap (const id) (const id) <<$>> a <<*>> b

-- | Keep the results of the first computation
(<<*) :: forall w a b c d. (Biapply w) => w a b -> w c d -> w a b
(<<*) a b = bimap const const <<$>> a <<*>> b

-- | Lift a function of two arguments.
bilift2 :: forall w a b c d e f. (Biapply w) => (a -> b -> c) -> (d -> e -> f) -> w a d -> w b e -> w c f
bilift2 f g a b = bimap f g <<$>> a <<*>> b

-- | Lift a function of three arguments.
bilift3 :: forall w a b c d e f g h. (Biapply w) => (a -> b -> c -> d) -> (e -> f -> g -> h) -> w a e -> w b f -> w c g -> w d h
bilift3 f g a b c = bimap f g <<$>> a <<*>> b <<*>> c

instance biapplyTuple :: Biapply Tuple where
  (<<*>>) (Tuple f g) (Tuple a b) = Tuple (f a) (g b)

instance biapplyConst :: Biapply Const where
  (<<*>>) (Const f) (Const x) = Const (f x)
