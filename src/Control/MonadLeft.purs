module Control.MonadLeft where

import Control.ApplicativeLeft (class ApplicativeLeft)
import Control.BindLeft (class BindLeft)

class (ApplicativeLeft m, BindLeft m) <= MonadLeft m
