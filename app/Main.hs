
module Main where 

import Lib

baseTemperature :: Double
baseTemperature = 60.0

nIterations :: Int
nIterations = 2000000

prettyPrintGrid :: Grid -> IO ()
prettyPrintGrid [] = putStrLn ""
prettyPrintGrid (g:gd) = do
  putStrLn $ show g
  _ <- prettyPrintGrid gd
  return ()

run :: Int -> BM -> [Bool] -> IO BM
run 0 bm _ = pure bm
run n bm fixed = do
  bm' <- randomUpdate temperature bm fixed
  --putStrLn $ show temperature
  --prettyPrintGrid $ makeGridFromBM bm'
  bm'' <- run (n-1) bm' fixed 
  return bm''
    where 
      -- multiplier = ((1 / baseTemperature) + (fromIntegral (n-1)) / (fromIntegral nIterations)) ^ 2
      multiplier = ((fromIntegral (n-1)) / (fromIntegral nIterations)) ^ 2
      temperature = baseTemperature * multiplier 
main :: IO ()
main = 
  let 
    bm = makeBMfromGrid easy
    fixed = listFixedValsInGrid easy
  in do 
    putStrLn "Starting..."
    bm' <- run nIterations bm fixed
    prettyPrintGrid $ makeGridFromBM bm'
    return ()
  
