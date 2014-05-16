module Control.Biapplicative where

import Data.Tuple
import Control.Biapply

class (Biapply w) <= Biapplicative w where
  bipure :: forall a b. a -> b -> w a b

instance biapplicativeTuple :: Biapplicative Tuple where
  bipure = Tuple
