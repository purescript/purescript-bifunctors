module Control.MonadLeft where

import Control.ApplicativeLeft (class ApplicativeLeft, lwhen, lunless)
import Control.BindLeft (class BindLeft, lbind)
import Data.Unit (Unit)

class (ApplicativeLeft m, BindLeft m) <= MonadLeft m

-- | Perform a monadic action when a condition is true, where the conditional
-- | value is also in a monadic context.
lwhenM :: forall m c. MonadLeft m => m Boolean c -> m Unit c -> m Unit c
lwhenM mb m = lbind mb \b -> lwhen b m

-- | Perform a monadic action unless a condition is true, where the conditional
-- | value is also in a monadic context.
lunlessM :: forall m c. MonadLeft m => m Boolean c -> m Unit c -> m Unit c
lunlessM mb m = lbind mb \b -> lunless b m
