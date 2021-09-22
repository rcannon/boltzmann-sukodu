
module InitialWeights(initialWeights) where

import BMBase (Value, Index, Matrix, matrix)
import Grid (boxSideLength, nGridValues, sqrtNumGridVals)

import Data.Tuple (swap)

sn :: Int
sn = sqrtNumGridVals

n :: Int
n = nGridVals


allFourTuples :: [a] -> [(a,a,a,a)]
allFourTuples xs = 
  pure (,,,) <*> xs <*> xs <*> xs <*> xs

ijxy :: [(Int, Int, Int, Int)]
ijxy = allFourTuples [0..sn]

uncurry4 :: (a -> b -> c -> d -> e) -> (a,b,c,d) -> e
uncurry4 f (a,b,c,d) = f a b c d

sudToVecIndex :: Int -> Int -> Int -> Int -> Int
sudToVecIndex x y z w = (x * sn + z) + n * (y * sn + w)

ms :: [Int]
ms = map (uncurry4 sudToVecIndex) ijxy

firstSet :: [(Index, Index)]
firstSet = [(setI m u, setI m v) | m <- ms, 
                                   u <- [0..n], 
                                   v <- [0..u]]
  where setI x y = n * x + y

makeIndex :: Int -> Int -> Int -> Int -> Int -> Index
makeIndex v a b c d = n * (sudToVecIndex a b c d) + v


secondSet :: [(Index, Index)]
secondSet = [(makeIndex val i j x y , makeIndex val i j u v) 
                | u <- [0..sn], 
                  v <- [0..sn], 
                  (i,j,x,y) <- ijxy,
                  val <- [0..n],
                  not (u == x && v == y)]

thirdSet :: [(Index, Index)]
thirdSet = [(makeIndex val i j x y , makeIndex val u j v y) 
              | u <- [0..sn], 
                v <- [0..sn], 
                (i,j,x,y) <- ijxy,
                val <- [0..n],
                not (u == i && v == x)]


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

nCols :: Index
nCols = n * boxSideLength ^ 4

weightList :: [[Value]]
weightList = map indexToVal allPairs
  where 
    indexToVal pair = if elem pair fixedValIndices
                      then -100.0
                      else 0.0
    allPairs = [ (i,j) | j <- [0..(nCols-1)], i <- [0..(nCols-1)]


initialWeights :: Matrix Value
initialWeights = matrix nCols weightList
