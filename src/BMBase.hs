
module BMBase where

import qualified Data.Vector.Generic as V
import qualified Numeric.LinearAlgebra as LA
import qualified Numeric.LinearAlgebra.Data as LAD

-- type synonyms
type Index = Int
type Value = LAD.R
type Vector = LAD.Vector
type Matrix = LAD.Matrix

type Excludes = [Bool]
type Temperature = Value
type Values = Vector Value
type Biases = Vector Value
type Weights = Matrix Value

-- Boltzmann Machine
data BM = BM Weights Biases Values

-- Matrix/Vector functions
(//) :: Vector Value -> [(Index, Value)] -> Vector Value
(//) = (V.//)

(!) :: Vector Value -> Index -> Value
(!) = (LAD.!)

(#>) :: Matrix Value -> Vector Value -> Vector Value
(#>) = (LA.#>)

add :: Vector Value -> Vector Value -> Vector Value
add = LA.add

matrix :: Index -> [Value] -> Matrix Value
matrix = LAD.matrix

vector :: [Value] -> Vector Value
vector = LAD.vector
