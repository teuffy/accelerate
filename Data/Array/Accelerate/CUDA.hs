-- |
-- Module      : Data.Array.Accelerate.CUDA
-- Copyright   : [2008..2009] Manuel M T Chakravarty, Gabriele Keller, Sean Lee
-- License     : BSD3
--
-- Maintainer  : Manuel M T Chakravarty <chak@cse.unsw.edu.au>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- This module is the CUDA backend for the embedded array language.
--

module Data.Array.Accelerate.CUDA (

    -- * Generate and execute CUDA code for an array expression
    Arrays, run

  ) where

import Data.Array.Accelerate.AST
import Data.Array.Accelerate.CUDA.State
import Data.Array.Accelerate.CUDA.Compile
import Data.Array.Accelerate.CUDA.Execute
import Data.Array.Accelerate.CUDA.Array.Device
import qualified Data.Array.Accelerate.Smart as Sugar


-- Accelerate: CUDA
-- ~~~~~~~~~~~~~~~~

-- | Compiles and run a complete embedded array program using the CUDA backend
--
run :: Arrays a => Sugar.Acc a -> IO a
run acc = evalCUDA
        $ execute (Sugar.convertAcc acc) >>= collect

execute :: Arrays a => Acc a -> CIO a
execute acc = compileAcc acc >> executeAcc acc

