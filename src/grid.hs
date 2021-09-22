
module Grid where

type GridVal = Int
type Grid = [[GridVal]]

values :: [GridVal]
values = [1..9]

nGridValues :: Int
nGridValues = length values

sqrtNumGridVals :: Int
sqrtNumGridVals = floor $ sqrt $ fromIntegral numValues

boxSideLength :: Int
boxSideLength = 3


