
module Bm where

import qualified Data.Vector.Generic as V
import qualified Numeric.LinearAlgebra as LA
import Numeric.LinearAlgebra.Data

type Excludes = [Bool]
type Index = Int
type Value = Double

type Temperature = Value
type Values = Vector Value
type Biases = Vector Value
type Weights = Matrix Value
data BM = BM Weights Biases Values

scaleValForUpdate :: Temperature -> Value -> Value
scaleValForUpdate t = negate . (/ t)

getValForUpdate :: BM -> Index -> Value
getValForUpdate (BM wss bs vs) idx 
  = flip (!) idx $ LA.add bs $ (LA.#>) wss $ (V.//) vs [(idx, 0.0)]
      
