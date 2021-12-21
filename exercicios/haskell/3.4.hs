import Data.List

myisort :: Ord a => [a] -> [a]

myisort a = foldr (insert) [] a 