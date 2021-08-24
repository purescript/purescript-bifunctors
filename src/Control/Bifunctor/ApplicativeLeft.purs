module Control.Bifunctor.ApplicativeLeft where

import Prelude
import Control.Bifunctor.ApplyLeft (class ApplyLeft)

-- | Same as `Applicative` but works on the left parameter in a Bifunctor.
class ApplyLeft m <= ApplicativeLeft m where
  lpure :: forall a b. a -> m a b

-- | Perform an applicative action when a condition is true.
whenLeft :: forall m c. ApplicativeLeft m => Boolean -> m Unit c -> m Unit c
whenLeft true m = m
whenLeft false _ = lpure unit

-- | Perform an applicative action unless a condition is true.
unlessLeft :: forall m c. ApplicativeLeft m => Boolean -> m Unit c -> m Unit c
unlessLeft false m = m
unlessLeft true _ = lpure unit
