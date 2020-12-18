module Control.BindLeft where

import Data.Unit (Unit)
import Control.Category (identity)

-- | Same as `Discard` but works on the left parameter of the bifunctor
-- | rather than the right parameter, which is the default for `Discard`.
class DiscardLeft a where
  ldiscard :: forall k (m :: Type -> k -> Type) b r. BindLeft m => m a r -> (a -> m b r) -> m b r

instance discardLeftUnit :: DiscardLeft Unit where
  ldiscard ma aToMB = lbind ma aToMB

-- | Same as `Bind` but works on the left parameter of the bifunctor
-- | rather than the right parameter, which is the default for `Bind`.
class BindLeft :: forall k. (Type -> k -> Type) -> Constraint
class BindLeft m where
  lbind :: forall a b r. m a r -> (a -> m b r) -> m b r

joinLeft :: forall m a r. BindLeft m => m (m a r) r -> m a r
joinLeft m = lbind m identity

composeKleisliLeft :: forall m a b c r. BindLeft m => (a -> m b r) -> (b -> m c r) -> a -> m c r
composeKleisliLeft aToMB bToMC a = lbind (aToMB a) bToMC

composeKleisliFlippedLeft :: forall m a b c r. BindLeft m => (b -> m c r) -> (a -> m b r) -> a -> m c r
composeKleisliFlippedLeft bToMC aToMB a = lbind (aToMB a) bToMC

ifMLeft :: forall m a r. BindLeft m => m Boolean r -> m a r -> m a r -> m a r
ifMLeft cond truePath falsePath = lbind cond \b -> if b then truePath else falsePath
