module Control.ApplyLeft where

import Prelude
import Data.Bifunctor (class Bifunctor, lmap)

-- | Same as `Apply` but works on the left parameter in a Bifunctor.
class Bifunctor w <= ApplyLeft w where
  lapply :: forall a b c. w (a -> b) c -> w a c -> w b c

-- | Combine two effectful actions, keeping only the result of the first.
lapplyFirst :: forall a b c w. ApplyLeft w => w a c -> w b c -> w a c
lapplyFirst a b = lapply (lmap const a) b

-- | Combine two effectful actions, keeping only the result of the second.
lapplySecond :: forall w a b c. ApplyLeft w => w a c -> w b c -> w b c
lapplySecond a b = lapply (lmap (const identity) a) b

-- | Lift a function of two arguments to a function which accepts and returns
-- | values wrapped with the type constructor `f`.
llift2 :: forall a b c w x. ApplyLeft w => (a -> b -> c) -> w a x -> w b x -> w c x
llift2 f a b = f `lmap` a `lapply` b

-- | Lift a function of three arguments to a function which accepts and returns
-- | values wrapped with the type constructor `f`.
llift3 :: forall a b c d w x. ApplyLeft w => (a -> b -> c -> d) -> w a x -> w b x -> w c x -> w d x
llift3 f a b c = f `lmap` a `lapply` b `lapply` c

-- | Lift a function of four arguments to a function which accepts and returns
-- | values wrapped with the type constructor `f`.
llift4 :: forall a b c d e w x. ApplyLeft w => (a -> b -> c -> d -> e) -> w a x -> w b x -> w c x -> w d x -> w e x
llift4 f a b c d = f `lmap` a `lapply` b `lapply` c `lapply` d

-- | Lift a function of five arguments to a function which accepts and returns
-- | values wrapped with the type constructor `f`.
llift5 :: forall a b c d e g w x. ApplyLeft w => (a -> b -> c -> d -> e -> g) -> w a x -> w b x -> w c x -> w d x -> w e x -> w g x
llift5 f a b c d e = f `lmap` a `lapply` b `lapply` c `lapply` d `lapply` e
