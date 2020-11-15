module Control.MonadLeft where

import Control.Biapplicative (class Biapplicative)
import Control.BindLeft (class BindLeft)

class (Biapplicative m, BindLeft m) <= MonadLeft m
