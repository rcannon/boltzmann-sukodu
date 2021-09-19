module Sud where

import Data.List
import Boltzmann
import Grid

-- needs bool of each term in BM.vals
listFixedValsInGrid :: Grid -> [Bool]
listFixedValsInGrid grid = concat $ map (concat . (map isFixed)) grid
  where isFixed c = if c == 0 
                    then take 9 (repeat False) 
                    else take 9 (repeat True)

listToGrid :: Row Value -> Grid
listToGrid xs = take rowsize xs : listToGrid (drop rowsize xs)
  where rowsize = boxSideLength ^ 2

