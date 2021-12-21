
padWithZeroes a b =
    if (length a > length b)
        then [0 | x <- [0..((length a - length b)-1)]] ++ b
    else b

addPoly :: [Int] -> [Int] -> [Int]

addPoly a b =
    if (null a) then []
    else [head la + head lb] ++ (addPoly (tail la) (tail lb))
    where la = padWithZeroes b a
          lb = padWithZeroes a b