
module Grid where

type Value = Int
type Grid = [[Value]]

values :: [Value]
values = [1..9]

numValues :: Int
numValues = length values

boxSideLength :: Int
boxSideLength = 3


