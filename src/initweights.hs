
module InitWeights where

import Mat
import Grid (boxSideLength, numValues)
import Data.List

-- Size of weight matrix

weightMatSideLength :: Int
weightMatSideLength = numValues * boxSideLength ^ 4

weightMatSize :: Int
weightMatSize = weightMatSideLength ^ 2

-- Weight matrix initialization

sudToVecIndex :: Int -> Int -> Int -> Int -> Int
sudToVecIndex x y z w = (x * 3 + z) + 9 * (y * 3 + w)

allFourTuples :: [a] -> [b] -> [c] -> [d] -> [(a,b,c,d)]
allFourTuples xs ys zs ws = do
  x <- xs
  y <- ys
  z <- zs
  w <- ws
  return (x,y,z,w)

ijxy :: [(Int, Int, Int, Int)]
ijxy = allFourTuples [0..3] [0..3] [0..3] [0..3]

uncurry4 :: (a -> b -> c -> d -> e) -> (a,b,c,d) -> e
uncurry4 f (a,b,c,d) = f a b c d

ms :: [Int]
ms = map (uncurry4 sudToVecIndex) ijxy

swap :: (a,b) -> (b,a)
swap (a,b) = (b,a)

--fullSet :: [(a,a)] -> [(a,a)]
--fullSet set = set ++ (map swap set)

firstSet :: [(Int, Int)]
firstSet = [(9*m + u, 9*m + v) | m <- ms, 
                                 u <- [0..9], 
                                 v <- [0..u]]

makeIndex :: Int -> Int -> Int -> Int -> Int -> Int
makeIndex val a b c d = 9 * (sudToVecIndex a b c d) + val

secondSet :: [(Int, Int)]
secondSet = [(makeIndex val i j x y , makeIndex val i j u v) 
                | u <- [0..3], 
                  v <- [0..3], 
                  (i,j,x,y) <- ijxy,
                  val <- [0..9],
                  not (u == x && v == y)]

thirdSet :: [(Int, Int)]
thirdSet = [(makeIndex val i j x y , makeIndex val u j v y) 
              | u <- [0..3], 
                v <- [0..3], 
                (i,j,x,y) <- ijxy,
                val <- [0..9],
                not (u == i && v == x)]


fourthSet :: [(Int, Int)]
fourthSet = [(makeIndex val i j x y , makeIndex val i u x v) 
              | u <- [0..3], 
                v <- [0..3], 
                (i,j,x,y) <- ijxy,
                val <- [0..9],
                not (u == j && v == y)]

negative100Indices :: [Int]
negative100Indices = 
  map (toIndex . sortPair) $ concat [firstSet, secondSet, thirdSet, fourthSet]

setValue :: Int -> Double
setValue idx = if elem idx negative100Indices then -100.0
                                              else 0.0

fullIndexList :: [(Int, Int)]
fullIndexList = [(i,j) | i <- [0..n], j <- [0..n]]
  where n = weightMatSideLength

dropN :: [[a]] -> [[a]]
dropN = dropNHelp 0

dropNHelp :: Int -> [[a]] -> [[a]]
dropNHelp _ [] = []
dropNHelp n xs = drop n (head xs) : dropNHelp (n+1) (tail xs)

vecToMat :: Int -> [a] -> [[a]]
vectToMat _ [] = []
vecToMat n xs = take n xs : vecToMat n (drop n xs)

initialWeights :: SymMat Double
initialWeights = SM (length wss) wss
  where 
    wss = dropN $ vecToMat weightMatSideLength $ map (setValue . toIndex) fullIndexList

