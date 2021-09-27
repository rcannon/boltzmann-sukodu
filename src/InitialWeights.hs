
module InitialWeights(initialWeights) where

import BMBase (Value, Index, Matrix, matrix)
import Grid (nGridValues, sqrtNumGridVals, cubeNumGridVals)

import Data.Tuple (swap)

{-

This module generates the initial weights for
our Boltzmann machine. The code is mostly 
indexing for specifying which elements in the
weight matrix are initially set to 0.0 or -100.0,
based on the rules of sudoku. The lists of index
pairs we specify below coorespond to the elements
that should be given negative weight.

-}

sn :: Int
sn = sqrtNumGridVals-1

n :: Int
n = nGridValues-1

allFourTuples :: [a] -> [(a,a,a,a)]
allFourTuples xs = 
  pure (,,,) <*> xs <*> xs <*> xs <*> xs

ijxy :: [(Int, Int, Int, Int)]
ijxy = allFourTuples [0..sn]

sudToVecIndex :: Int -> Int -> Int -> Int -> Index
sudToVecIndex x y z w = (x * sn + z) + n * (y * sn + w)

ms :: [Int]
ms = map (uncurry4 sudToVecIndex) ijxy
  where 
    uncurry4 f (a,b,c,d) = f a b c d

-- sudoku spot can't be occupied by more than one number
firstSet :: [(Index, Index)]
firstSet = [(setI m u, setI m v) | m <- ms, 
                                   u <- [0..n], 
                                   v <- [0..(u-1)]]
  where setI x y = n * x + y

makeIndex :: Int -> Int -> Int -> Int -> Int -> Index
makeIndex v a b c d = n * (sudToVecIndex a b c d) + v

-- only one of each number can occur in any given square
secondSet :: [(Index, Index)]
secondSet = [(makeIndex val i j x y , makeIndex val i j u v) 
                | u <- [0..sn], 
                  v <- [0..sn], 
                  (i,j,x,y) <- ijxy,
                  val <- [0..n],
                  not (u == x && v == y)]

-- only one of each number can occur in any given column
thirdSet :: [(Index, Index)]
thirdSet = [(makeIndex val i j x y , makeIndex val u j v y) 
              | u <- [0..sn], 
                v <- [0..sn], 
                (i,j,x,y) <- ijxy,
                val <- [0..n],
                not (u == i && v == x)]

-- only one of each number can occur in any given row
fourthSet :: [(Index, Index)]
fourthSet = [(makeIndex val i j x y , makeIndex val i u x v) 
              | u <- [0..sn], 
                v <- [0..sn], 
                (i,j,x,y) <- ijxy,
                val <- [0..n],
                not (u == j && v == y)]

fixedValIndices :: [(Index, Index)]
fixedValIndices = 
  let pairs = concat [firstSet, secondSet, thirdSet, fourthSet] in
    (++) <$> id <*> map swap $ pairs


-- number of columns in weight matrix
nCols :: Index
nCols = cubeNumGridVals 

weightList :: [Value]
weightList = map indexToVal allPairs
  where 
    indexToVal pair = if elem pair fixedValIndices
                      then -100.0
                      else 0.0
    allPairs = [ (i,j) | j <- [0..(nCols-1)], i <- [0..(nCols-1)]]

initialWeights :: Matrix Value
initialWeights = matrix nCols weightList
