
module Main where 

import Lib

baseTemperature :: Double
baseTemperature = 100.0

nIterations :: Integer
nIterations = 1000000

power :: Int
power = 2

prettyPrintGrid :: Grid -> IO ()
prettyPrintGrid [] = putStrLn ""
prettyPrintGrid (g:gd) = do
  putStrLn $ show g
  _ <- prettyPrintGrid gd
  return ()

run :: Integer -> BM -> [Bool] -> IO BM
run 0 bm _ = pure bm
run n bm fixed = do
  bm' <- randomUpdate temperature bm fixed
  bm'' <- run (n-1) bm' fixed 
  return bm''
    where 
      x = (fromIntegral n) / (fromIntegral nIterations)
      multiplier = min 1.0 $ (x ^ power) * ((exp x) - 1)
      temperature = baseTemperature * multiplier 

main :: IO ()
main = 
  let 
    bm = makeBMfromGrid easy
    fixed = listFixedValsInGrid easy
  in do
    putStrLn "" 
    putStrLn "Running the Boltzmann Machine..."
    putStrLn ""
    bm' <- run nIterations bm fixed
    prettyPrintGrid $ makeGridFromBM bm'
    return ()
  
