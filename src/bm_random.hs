
module BMRandom(getRandomNonExcludedIndex
              , getRandomNewVal) where

import BMBase(Value, Index, Excludes)

import System.Random
import System.Random.Stateful

gen :: IO StGen
gen = getStdGen

getRandomValue :: IO Value
getRandomValue = randomIO

getRandomNonExcludedIndex :: Excludes -> IO Index
getRandomNonExcludedIndex excl = do
  idx <- randomRIO (0, l-1) :: IO Index
  return $ ns !! idx
    where
      ns = [n | (b,n) <- zip excl [0..], not b]
      l = length ns
