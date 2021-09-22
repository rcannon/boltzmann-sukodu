
module InitialWeights(initialWeights) where

import BMBase (Value, Index, Matrix, matrix)
import Grid (boxSideLength, numValues)

weightMatrixSize :: Int
weightMatrixSize = numValues * boxSideLength ^ 4

nCols :: Int
nCols = undefined

initialWeights :: Matrix Value
initialWeights = matrix nCols weightList
