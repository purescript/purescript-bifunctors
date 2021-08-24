module Control.Bifunctor.ApplyLeft where

import Prelude
import Data.Bifunctor (class Bifunctor, lmap)

-- | Same as `Apply` but works on the left parameter in a Bifunctor.
class Bifunctor m <= ApplyLeft m where
  lapply :: forall a b c. m (a -> b) c -> m a c -> m b c

-- | Combine two effectful actions, keeping only the result of the first.
applyFirstLeft :: forall a b c m. ApplyLeft m => m a c -> m b c -> m a c
applyFirstLeft a b = lapply (lmap const a) b

-- | Combine two effectful actions, keeping only the result of the second.
applySecondLeft :: forall m a b c. ApplyLeft m => m a c -> m b c -> m b c
applySecondLeft a b = lapply (lmap (const identity) a) b

-- | Lift a function of two arguments to a function which accepts and returns
-- | values wrapped with the type constructor `f`.
lift2Left :: forall a b c m x. ApplyLeft m => (a -> b -> c) -> m a x -> m b x -> m c x
lift2Left f a b = f `lmap` a `lapply` b

-- | Lift a function of three arguments to a function which accepts and returns
-- | values wrapped with the type constructor `f`.
lift3Left :: forall a b c d m x. ApplyLeft m => (a -> b -> c -> d) -> m a x -> m b x -> m c x -> m d x
lift3Left f a b c = f `lmap` a `lapply` b `lapply` c

-- | Lift a function of four arguments to a function which accepts and returns
-- | values wrapped with the type constructor `f`.
lift4Left :: forall a b c d e m x. ApplyLeft m => (a -> b -> c -> d -> e) -> m a x -> m b x -> m c x -> m d x -> m e x
lift4Left f a b c d = f `lmap` a `lapply` b `lapply` c `lapply` d

-- | Lift a function of five arguments to a function which accepts and returns
-- | values wrapped with the type constructor `f`.
lift5Left :: forall a b c d e g m x. ApplyLeft m => (a -> b -> c -> d -> e -> g) -> m a x -> m b x -> m c x -> m d x -> m e x -> m g x
lift5Left f a b c d e = f `lmap` a `lapply` b `lapply` c `lapply` d `lapply` e
