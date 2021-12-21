binom :: Int -> Int -> Int
binom n k = product [1+n-k..n] `div` product [1..k]

pascal = [1] : [(line (length y) 0) | y <- pascal]

line l i = 
    if (i == l+1) then []
    else binom l i : (line l (i+1))


pascal2 = [1] :  [[a + b|(a,b) <- zip (0 :y ++ [0]) (tail (0 :y ++ [0]))] | y <- pascal]