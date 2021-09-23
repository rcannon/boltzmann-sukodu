
module BoltsMach (randomUpdate) where

import qualified BMBase as Bm
import BMRandom (getRandomNonExcludedIndex
               , getRandomNewVal)

type Temperature = Bm.Temperature
type Index = Bm.Index
type BM = Bm.BM

scaleValForUpdate :: Temperature -> Value -> Value
scaleValForUpdate t = negate . (/ t)

getValForUpdate :: BM -> Index -> Value
getValForUpdate (BM wss bs vs) idx 
  = flip (Bm.!) idx $ Bm.add bs $ (Bm.#>) wss $ (Bm.//) vs [(idx, 0.0)]

updateBMWithNewVal :: Bm.BM -> Index -> Value -> Bm.BM
updateBMWithNewVal (BM wss bs vs) idx newVal = 
  = (BM wss bs) $ (Bm.//) vs [(idx, newVal)]
      
randomUpdate :: Temperature -> BM -> Excludes -> IO BM
randomUpdate t bm excl = do
  idx <- getRandomNonExlcudedIndex excl
  newVal <- getRandomNewVal $ scaleValForUpdate t $ getValForUpdate bm idx
  return $ updateBMWithNewVal bm idx newVal

