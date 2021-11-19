
module Main where 

import Lib

temperature :: Double
temperature = 60.0

nIterations :: Int
nIterations = 200

run :: Int -> BM -> [Bool] -> IO BM
run 0 bm _ = pure bm
run n bm fixed = do
  bm' <- randomUpdate temperature bm fixed
  putStrLn $ show $ makeGridFromBM bm'
  bm'' <- run (n-1) bm' $ listFixedValsInGrid $ makeGridFromBM bm'
  return bm''

main :: IO ()
main = 
  let 
    bm = makeBMfromGrid easy
    fixed = listFixedValsInGrid easy
  in do 
    putStrLn "Starting..."
    bm' <- run nIterations bm fixed
    putStrLn $ show $ makeGridFromBM bm'
    return ()
  
