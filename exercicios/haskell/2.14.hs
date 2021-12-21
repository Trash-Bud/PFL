nub :: Eq a => [a] ->[a]

nub a =  
    if (length l == 1) then [(head l)]
    else [(head l)] ++ (nub (tail l))
    where l = head a : [x | x <- (tail a), x /= (head a)]