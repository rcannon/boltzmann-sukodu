
module Grid where

type Row a = [a]
type Matrix a = [Row a]
type Value = Int
type Grid = Matrix Value

complete :: Grid -> Bool
complete = all (all (isInVal))
  where isInVal = flip elem values

boxSideLength :: Int
boxSideLength = 3

values :: [Value]
values = [1..9]

numValues :: Int
numValues = length values
