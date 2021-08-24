-- | Enables one to use `ado notation` and `do notation` on the left parameter
-- | of a Bifunctor.
-- |
-- | `ado notation` example
-- | ```
-- | import Control.MonadLeft.Qualified as MonadLeft
-- |
-- | foo :: Either Int String -> Either String String
-- | foo comp = MonadLeft.ado
-- |   a <- comp
-- |   b <- comp
-- |   in show $ a + b
-- | ```
-- | `do notation` example
-- | ```
-- | import Control.MonadLeft.Qualified as MonadLeft
-- |
-- | foo :: Either Int String -> Either String String
-- | foo comp = MonadLeft.do
-- |   a <- comp
-- |   b <- comp
-- |   lpure $ show $ a + b
-- | ```
module Control.MonadLeft.Qualified where

import Control.ApplyLeft (class ApplyLeft, lapply)
import Control.BindLeft (class BindLeft, lbind, class DiscardLeft, ldiscard)
import Data.Bifunctor (class Bifunctor, lmap)

discard :: forall m a b r. DiscardLeft a => BindLeft m => m a r -> (a -> m b r) -> m b r
discard = ldiscard

bind :: forall m a b r. BindLeft m => m a r -> (a -> m b r) -> m b r
bind = lbind

apply :: forall m a b c. ApplyLeft m => m (a -> b) c -> m a c -> m b c
apply = lapply

map :: forall m a b c. Bifunctor m => (a -> b) -> m a c -> m b c
map = lmap
