
module Mat where

import Data.List
import Data.Foldable
import Data.Tuple

{- Symmetric Matrices -}

data SymMat a = SM Int [[a]] 
              deriving (Eq, Show)

isValid :: SymMat a -> Bool
isValid (SM l xss) = l == length (head xss) &&
                     isValid (SM (l-1) (tail xss))

sortPair :: Ord a => (a,a) -> (a,a)
sortPair (a,b) 
  | a <= b = (a,b)
  | otherwise = (b,a)

{- Matrix and vector utilites -}

toIndex :: (Int, Int) -> Int
toIndex pr = (+) b $ flip div 2 $ a * (a + 1) 
  where (a,b) = sortPair pr

getLength :: Num a => SymMat a -> Int
getLength (SM l mss) = l

-- vector sum and dot product
foldTogether :: (a -> b -> c) -> (c -> d -> d) -> d -> [a] -> [b] -> d
foldTogether _ _ b [] _ = b
foldTogether _ _ b _ [] = b
foldTogether f op b (x:xs) (y:ys) = op (f x y) $ foldTogether f op b xs ys

vecSum :: Num a => [a] -> [a] -> [a]
vecSum = foldTogether (+) (:) []

dotProd :: Num a => [a] -> [a] -> a
dotProd = foldTogether (*) (+) 0

-- right matrix multiplication, taking advantage of symmetry

symMatVecProd :: Num a => SymMat a -> [a] -> [a]
symMatVecProd (SM l ms) xs = symMatVecProdHelp [] (SM l ms) xs 0

symMatVecProdHelp :: Num a => [[a]] -> SymMat a -> [a] -> Int -> [a]
symMatVecProdHelp preds (SM l ms) xs n 
  | n >= l    = []
  | otherwise = dotProd xs m : symMatVecProdHelp preds' (SM (l-1) succTail) xs (n+1)
  where 
    succHead = head ms
    succTail = tail ms
    nthPreds = map (flip (!!) n) preds
    m = nthPreds ++ succHead
    preds' = reverse $ succHead : (reverse preds)

{-
symMatTranspose (SM l ms) n 
  | n >= l = 
  

singleRowSymMatVecProd :: Num a => SymMat a -> [a] -> Int -> [a]
singleRowSymMatVecProd (SM l ms) xs n = dotProd xs msRow
  where
    msRow = 
-}

-- change from vector form to upper triange matrix form
{-
symSplit :: SymMat a -> [[a]]
symSPlit (SM 0 _) = []
symSplit (SM l ms) = take l ms : symSplit (SM (l-1) (drop l ms))
-}
