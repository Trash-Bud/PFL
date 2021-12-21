calcPi1, calcPi2 :: Int -> Double

num1 = 4 : -4 : num1
den1 = 1 : 3: zipWith (+) dois (tail(den1))
dois = 2: dois

calcPi1 n = foldr (+) 0 (zipWith (/) (take n num1) (take n den1))

num2 = 3 : num1
den2 = 1.0 : (tail [x * (x-1) * (x+1) | x <- den1])
um = 1 : um

calcPi2 n = foldr (+) 0 (zipWith (/) (take n num2) (take n den2))