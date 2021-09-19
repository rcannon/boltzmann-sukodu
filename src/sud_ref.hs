
module Sud where

import Data.List

type Row a = [a]
type Matrix a = [Row a]
type Value = Char
type Grid = Matrix Value

boxsize :: Int
boxsize = 3

values :: [Value]
values = ['1'..'9']

isEmpty :: Value -> Bool
isEmpty = (== '.')

single :: [a] -> Bool
single [_] = True
single _ = False

empty :: Grid 
empty = replicate n (replicate n '.')
        where n = boxsize ^ 2

easy :: Grid
easy =   ["2....1.38",
          "........5",
          ".7...6...",
          ".......13",
          ".981..257",
          "31....8..",
          "9..8...2.",
          ".5..69784",
          "4..25...."]

gentle :: Grid
gentle =   [".1.42...5",
            "..2.71.39",
            ".......4.",
            "2.71....6",
            "....4....",
            "6....74.3",
            ".7.......",
            "12.73.5..",
            "3...82.7."]

diabolical :: Grid
diabolical =  [".9.7..86.",
               ".31..5.2.",
               "8.6......",
               "..7.5...6",
               "...3.7...",
               "5...1.7..",
               "......1.9",
               ".2.6..35.",
               ".54..8.7."]

unsolvable :: Grid
unsolvable =  ["1..9.7..3",
               ".8.....7.",
               "..9...6..",
               "..72.94..",
               "41.....95",
               "..85.43..",
               "..3...7..",
               ".5.....4.",
               "2..8.6..9"]

minimal :: Grid
minimal =    [".98......",
              "....7....",
              "....15...",
              "1........",
              "...2....9",
              "...9.6.82",
              ".......3.",
              "5.1......",
              "...4...2."]

--------------------------------------------
-- note: double application of any single 
-- fn below is identity
rows :: Matrix a -> [Row a]
rows = id

cols :: Matrix a -> [Row a]
cols = transpose

boxs :: Matrix a -> [Row a]
boxs = unpack . map cols . pack
       where
         pack = split . map split
         split = chop boxsize
         unpack = map concat . concat

--------------------------------------------

chop :: Int -> [a] -> [[a]]
chop _ [] = []
chop n xs = (take n xs) : chop n (drop n xs)

isValid :: Grid -> Bool
isValid m = all nodups (rows m) && 
            all nodups (cols m) && 
            all nodups (boxs m)

nodups :: Eq a => [a] -> Bool
nodups [] = True
nodups (x:xs) = not (elem x xs) && nodups xs

type Choices = [Value]

choices :: Grid -> Matrix Choices
choices = map (map choice)
          where
            choice v = if isEmpty v then values else [v]

cartProd :: [[a]] -> [[a]]
cartProd [] = [[]]
cartProd (x:xs) = [ y:ys | y <- x, ys <- cartProd xs]

collapse :: Matrix [a] -> [Matrix a]
collapse = cartProd . map cartProd

solve :: Grid -> [Grid]
solve = filter isValid . collapse . choices

minus :: Choices -> Choices -> Choices
minus xs ys = if single xs then xs else xs \\ ys

reduce :: Row Choices -> Row Choices
reduce xss = [minus xs singles | xs <- xss]
             where singles = concat (filter single xss)

prune :: Matrix Choices -> Matrix Choices
prune = pruneBy boxs . pruneBy cols . pruneBy rows
        where pruneBy f = f . map reduce . f

solve2 :: Grid -> [Grid]
solve2 = filter isValid. collapse . prune . choices 

fixPoint :: (Eq a) => (a -> a) -> a -> a
fixPoint f x = if x == x' then x else fixPoint f x'
               where x' = f x

solve3 :: Grid -> [Grid]
solve3 = filter isValid . collapse . fixPoint prune . choices

complete :: Matrix Choices -> Bool
complete = all (all single)

void :: Matrix Choices -> Bool
void = any (any null)

consistent :: Row Choices -> Bool
consistent = nodups . concat . filter single 

safe :: Matrix Choices -> Bool
safe m = all consistent (rows m) &&
         all consistent (cols m) &&
         all consistent (boxs m)

blocked :: Matrix Choices -> Bool
blocked m = void m || not (safe m)

solve4 :: Grid -> [Grid]
solve4 = search . prune . choices

search :: Matrix Choices -> [Grid]
search m
  | blocked m = []
  | complete m = collapse m
  | otherwise = [g | m' <- expand m,
                     g <- search (prune m')]

expand :: Matrix Choices -> [Matrix Choices]
expand m = 
  [rows1 ++ [row1 ++ [c] : row2] ++ rows2 | c <- cs]
  where
    (rows1, row:rows2) = break (any (not . single)) m
    (row1, cs:row2) = break (not . single) row

main :: IO ()
main = putStrLn $ unlines $ head $ solve4 diabolical
