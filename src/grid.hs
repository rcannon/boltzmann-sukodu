
module Grid where

type GridVal = Int
type Grid = [[GridVal]]

gridValues :: [GridVal]
gridValues = [1..9]

nGridValues :: Int
nGridValues = length gridValues

{-
  used for BM value vector dimension
  and BM weight matrix row/column
  dimension. 

    (number of suduko rows) 
  x (number of suduko columns)
  x (number of possible values)
  = cubeNumGridVals
 note: each term in product must be equal since 
 exactly one of each value must go
 in each row/column/square
-}
cubeNumGridVals :: Int
cubeNumGridVals = nGridValues ^ 3

sqrtNumGridVals :: Int
sqrtNumGridVals = floor $ sqrt $ fromIntegral nGridValues

getExcludedValsFormat :: [Bool] -> [Bool]
getExcludedValsFormat excl = concat $ map (\b -> replicate nGridValues b) excl 

listFixedValsInGrid :: Grid -> [Bool]
listFixedValsInGrid gd = concat $ map (replicate nGridValues . (/= 0)) $ concat gd

