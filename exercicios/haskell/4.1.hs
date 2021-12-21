primos :: [Integer]
primos = crivo [2..]
crivo :: [Integer] -> [Integer]
crivo (p:xs) = p : crivo [x | x<-xs, x `mod` p/=0]

factores n = 
    if (n == 1) then []
    else factor  : factores (div n factor) 
    where factor = findp n 0

findp n i =
    if (mod n (primos !! i) == 0) then primos !! i
    else findp n (i+1)
