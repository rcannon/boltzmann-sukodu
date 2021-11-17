
module Main where 

import Lib

temperature :: Double
temperature = 60.0

nIterations :: Int
nIterations = 1

run :: Int -> [Bool] -> BM -> IO BM
run 0 _ bm = pure bm
run n fixed bm = do
  bm' <- run (n-1) fixed bm
  bm'' <- randomUpdate temperature bm' fixed
  return bm''

main :: IO ()
main = 
  let 
    bm = makeBMfromGrid easy
    fixed = listFixedValsInGrid easy
  in do 
    putStrLn "Starting..."
    bm' <- run nIterations fixed bm
    putStrLn $ show $ makeGridFromBM bm'
    return ()
  
