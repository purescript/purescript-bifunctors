module Control.Biapplicative where

import Data.Const
import Data.Tuple

import Control.Biapply

-- | `Biapplicative` captures type constructors of two arguments which support lifting of
-- | functions of zero or more arguments, in the sense of `Applicative`.
class (Biapply w) <= Biapplicative w where
  bipure :: forall a b. a -> b -> w a b

instance biapplicativeTuple :: Biapplicative Tuple where
  bipure = Tuple

instance biapplicativeConst :: Biapplicative Const where
  bipure a _ = Const a
