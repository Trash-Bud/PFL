fromBits :: [Int] -> Int

fromBits a = 
    if (null a) then 0
    else (a !! 0)*(2^((length a)-1)) + (fromBits (tail a)) 