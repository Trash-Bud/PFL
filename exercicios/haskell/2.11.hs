myconcat:: [[a]] -> [a]

myconcat a = [x | y <- a, x <- y]

myreplicate:: Int -> a -> [a]

myreplicate a b = [b | x <- [1..a]]

myindex a b = head [y | (x,y) <- zip [0..(length a)] a, x == b]