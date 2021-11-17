
module BMRandom(getRandomNonExcludedIndex
              , getRandomValue) where

import BMBase(Value, Index, Excludes)

import System.Random
import System.Random.Stateful

gen :: IO StdGen
gen = getStdGen

getRandomValue :: Value -> IO Value
getRandomValue v = do
  d <- randomIO
  return $ if d < v then 1.0 else 0.0

getRandomNonExcludedIndex :: Excludes -> IO Index
getRandomNonExcludedIndex excl = do
  idx <- randomRIO (0, l-1) :: IO Index
  return $ ns !! idx
    where
      ns = [n | (b,n) <- zip excl [0..], not b]
      l = length ns
