
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
(//) = (V.//)
(!) = (LAD.!)
(#>) = (LA.#>)
add = LA.add
