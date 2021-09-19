
module Randomness where

import System.Random
import System.Random.Stateful

gen :: IO StdGen
gen = getStdGen

getRandomDouble :: IO Double
getRandomDouble = randomIO

getRandomNonExcludedIndex :: [Int] -> IO Int
getRandomNonExcludedIndex ns = do
  idx <- randomRIO (0, l-1) :: IO Int
  return (ns !! idx)
    where l = length ns


