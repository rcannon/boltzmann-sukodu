
module Boltzmann where

import Mat
import Grid 
import Randomness
import Data.Traversable

-- Type definitions and constants

type Values = [Double]
type Biases = [Double]
type Weights = SymMat Double
 
data BoltzMach = BM Values Biases Weights
  deriving (Eq, Show)

newFromWeights :: Weights -> BoltzMach
newFromWeights (SM l weights) = BM (replicate l 1) (replicate l 0) (SM l weights)

getVals :: BoltzMach -> Values
getVals (BM vs _ _) = vs

-- compute the current state of the board from the BM

chopByN :: Int -> [a] -> [[a]]
chopByN _ [] = []
chopByN n vs = (take n vs) : chopByN n (drop n vs)

bmValEntriesToSudEntry :: [Int] -> Int
bmValEntriesToSudEntry xs = if length bs == 1 then head bs else 0
  where bs = filter (/= 0) xs

bmUpdateGrid :: BoltzMach -> Grid
bmUpdateGrid (BM vs _ _) = chopByN 9 sud
  where 
    isActivated (n,x) = if x > 0.5 then n else 0  
    vs' = chopByN 9 vs
    sud = map bmValEntriesToSudEntry $ map ((map isActivated) . zip [1..9]) vs' 

-- compute the BM values from the sudoku board

gridTermToVal :: Int -> Values
gridTermToVal c = map (numIsEqual c) [1..9]
  where numIsEqual x y = if x == y then 1.0 else 0.0

setBMValues :: Grid -> Values
setBMValues grid = vs
  where vs = concat $ map gridTermToVal $ concat grid
 

-- Update Helpers

scaleValueForUpdate :: Double -> Double -> Double
scaleValueForUpdate t = ((/ t) . negate)

getNewVal :: (Bool, Double) -> IO Double
getNewVal (b,v) = do
  rd <- getRandomDouble
  return $ if (rd < thresh && b == False) then 1.0 else 0.0
    where thresh = (1.0 + 1 / (exp v))

filterOutTrue :: [(Bool, Int)] -> [Int]
filterOutTrue [] = []
filterOutTrue ((b, n):bns) = if b == False 
                             then n : filterOutTrue bns
                             else filterOutTrue bns

-- Update Methods

updateAllSequential :: Double -> BoltzMach -> [Bool] -> IO BoltzMach
updateAllSequential t (BM vs bs wss) exclude = do
  vs' <- sequenceA $ map getNewVal $ zip exclude $ map (scaleValueForUpdate t) vs''
  return (BM vs' bs wss)
  where
    vs'' = vecSum bs $ symMatVecProd wss vs

updateOneRandom :: Double -> BoltzMach -> [Bool] -> IO BoltzMach
updateOneRandom t (BM vs bs wss) exclude = do
  idx <- getRandomNonExcludedIndex $ filterOutTrue $ zip exclude [0..lex]
  putStrLn $ "the index is " ++ (show idx)
  newVal <- (curry getNewVal False . (scaleValueForUpdate t)) 
            $ (vecSum bs $ symMatVecProd wss vs) !! idx -- TODO: make this more efficient
  putStrLn $ "newVal is " ++ (show newVal)
  return $ let vs' = (take idx vs) ++ [newVal] ++ (drop (idx+1) vs) in (BM vs' bs wss)
    where 
      lex = (length exclude) - 1          

