
module BoltzMach (randomUpdate, makeBMfromGrid) where

import BMBase (BM(BM))
import qualified BMBase as Bm

import InitialWeights (initialWeights)
import Grid (gridValues, cubeNumGridVals, Grid)
import BMRandom (getRandomNonExcludedIndex
               , getRandomValue)

type Excludes = Bm.Excludes
type Index = Bm.Index
type Temperature = Bm.Temperature
type Value = Bm.Value
    
makeBMfromGrid :: Grid -> BM
makeBMfromGrid gd = BM weights biases values
  where
    weights = initialWeights
    biases = Bm.vector $ replicate cubeNumGridVals 10.0
    values = 
      let toActiveList x = map (\ y -> if y == x then 1.0 else 0.0) gridValues
      in Bm.vector $ concat $ map toActiveList $ concat gd

scaleValForUpdate :: Temperature -> Value -> Value
scaleValForUpdate t = negate . (/ t)

getValForUpdate :: BM -> Index -> Value
getValForUpdate (BM wss bs vs) idx 
  = flip (Bm.!) idx $ Bm.add bs $ (Bm.#>) wss $ (Bm.//) vs [(idx, 0.0)]

updateBMWithNewVal :: Bm.BM -> Index -> Value -> Bm.BM
updateBMWithNewVal (BM wss bs vs) idx newVal 
  = (BM wss bs) $ (Bm.//) vs [(idx, newVal)]
      
randomUpdate :: Temperature -> BM -> Excludes -> IO BM
randomUpdate t bm excl = do
  idx <- getRandomNonExcludedIndex excl
  newVal <- getRandomValue $ scaleValForUpdate t $ getValForUpdate bm idx
  return $ updateBMWithNewVal bm idx newVal

