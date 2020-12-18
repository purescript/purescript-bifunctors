module Control.MonadLeft where

import Control.ApplicativeLeft (class ApplicativeLeft, lwhen, lunless)
import Control.BindLeft (class BindLeft, lbind)
import Data.Unit (Unit)

class (ApplicativeLeft m, BindLeft m) <= MonadLeft m

-- | Perform a monadic action when a condition is true, where the conditional
-- | value is also in a monadic context.
whenMLeft :: forall m c. MonadLeft m => m Boolean c -> m Unit c -> m Unit c
whenMLeft mb m = lbind mb \b -> lwhen b m

-- | Perform a monadic action unless a condition is true, where the conditional
-- | value is also in a monadic context.
unlessMLeft :: forall m c. MonadLeft m => m Boolean c -> m Unit c -> m Unit c
unlessMLeft mb m = lbind mb \b -> lunless b m
