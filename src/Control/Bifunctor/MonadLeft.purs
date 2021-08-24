module Control.Bifunctor.MonadLeft where

import Control.Bifunctor.ApplicativeLeft (class ApplicativeLeft, whenLeft, unlessLeft)
import Control.Bifunctor.BindLeft (class BindLeft, lbind)
import Data.Unit (Unit)

class MonadLeft :: (Type -> Type -> Type) -> Constraint
class (ApplicativeLeft m, BindLeft m) <= MonadLeft m

-- | Perform a monadic action when a condition is true, where the conditional
-- | value is also in a monadic context.
whenMLeft :: forall m c. MonadLeft m => m Boolean c -> m Unit c -> m Unit c
whenMLeft mb m = lbind mb \b -> whenLeft b m

-- | Perform a monadic action unless a condition is true, where the conditional
-- | value is also in a monadic context.
unlessMLeft :: forall m c. MonadLeft m => m Boolean c -> m Unit c -> m Unit c
unlessMLeft mb m = lbind mb \b -> unlessLeft b m
