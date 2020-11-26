module Control.ApplicativeLeft where

import Prelude
import Control.ApplyLeft (class ApplyLeft, lapply)

-- | Same as `Applicative` but works on the left parameter in a Bifunctor.
class ApplyLeft w <= ApplicativeLeft w where
  lpure :: forall a b. a -> w a b

-- | Perform an applicative action when a condition is true.
lwhen :: forall m c. ApplicativeLeft m => Boolean -> m Unit c -> m Unit c
lwhen true m = m
lwhen false _ = lpure unit

-- | Perform an applicative action unless a condition is true.
lunless :: forall m c. ApplicativeLeft m => Boolean -> m Unit c -> m Unit c
lunless false m = m
lunless true _ = lpure unit
