
module Main where 

import System.Environment
import Debug.Trace
import Grid
import Sud
import Boltzmann
import SudExamples
import InitWeights (initialWeights)
import Mat

temperature :: Double
temperature = 60.0

ticks :: Int
ticks = 1

nVals :: Int
nVals = 81*9

game :: Grid
game = easy

doSudoku :: Int -> BoltzMach -> IO BoltzMach
doSudoku 0 bm = return bm
doSudoku ticks bm = do
  putStrLn $ "begin updating bm"
  bm' <- updateOneRandom temperature bm fixedVals 
  putStrLn $ "done updating bm, beginning next doSudoku"
  finalBM <- doSudoku (ticks-1) bm'
  putStrLn $ "finished doSudoku"
  return finalBM
    where
      fixedVals = listFixedValsInGrid $ bmUpdateGrid bm
       

{-showDoSudoku :: Int -> BoltzMach -> IO BoltzMach
showDoSudoku 0 bm = do
  putStrLn $ show $ bmUpdateGrid bm
  return bm
showDoSodoku ticks bm = do
  putStrLn $ show $ newGrid
  return $ doSudoku (ticks-1) newGrid bm
  where
    newGrid = bmUpdateGrid bm    -}

main :: IO ()
main = do
  putStrLn $ show $ symMatVecProd wss vs
  where
    vals = (setBMValues game)
    (BM vs bs wss) = (BM vals (take nVals (repeat 10.0)) initialWeights)


{-
    putStrLn $ show game
    machine' <- doSudoku ticks machine
    putStrLn $ "got final machine"
    putStrLn $ show $ bmUpdateGrid machine'
    putStrLn $ "prinded final grid"
    return ()
      where 
        vs = (setBMValues game)
        machine = (BM vs (take nVals (repeat 10.0)) initialWeights)
-}

{-getRandomNonExcludedIndex $ filterOutTrue $ zip exclude [1..(length exclude)] -}



{-(==) vs $ getVals $ updateOneRandom temperature machine $ listFixedValsInGrid $ bmUpdateGrid machine-}


{-let machine = (BM (setBMValues game) (take nVals (repeat 10.0)) initialWeights) in do
    putStrLn $ show game
    putStrLn "...\n"
    putStrLn "beginning game\n"
    putStrLn $ show $ game == (doSudoku ticks machine)-}
    
  {-putStrLn $ show $ exclude !! idx
    where 
      exclude = listFixedValsInGrid game 
      idx = getRandomNonExcludedIndex $ filterOutTrue $ zip exclude [1..(length exclude)]
-}
{-  let machine = (BM (setBMValues game) (take nVals (repeat 10.0)) initialWeights) in do
    putStrLn $ show game
    putStrLn "...\n"
    putStrLn $ show $ (==) game $ bmUpdateGrid $ updateOneRandom temperature machine $ listFixedValsInGrid game -}
    

{-putStrLn $ show game
    putStrLn "beginning game\n"
    putStrLn $ show $ game == (doSudoku ticks machine)-}
