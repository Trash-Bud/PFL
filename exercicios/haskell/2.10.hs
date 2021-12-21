myand:: [Bool] -> Bool

myand [] = True
myand a =
    if (length a) == 1 then a !! 0
    else ( a !! 0) && (myand (tail a))

myor:: [Bool] -> Bool

myor [] = True
myor a =
    if (length a) == 1 then a !! 0
    else ( a !! 0) || (myand (tail a))

myconcat:: [[a]] -> [a]

myconcat [] = []
myconcat a = 
    if (length a) == 1 then a !! 0
    else (a!!0) ++ (myconcat (tail a))

myreplicate:: Int -> a -> [a]

myreplicate a b =
    if (a == 0) then []
    else if (a == 1) then [b]
    else [b] ++ (myreplicate (a - 1) b)

myindex :: [a] -> Int -> a

myindex a b =
    if (b == 0) then  head a
    else myindex (tail a) (b-1)

myelem :: Eq a => a -> [a] -> Bool

myelem a b = 
    if (length b == 0) then False
    else if (b !! 0) == a then True
    else myelem a (tail b)

