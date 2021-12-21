toBits :: Int -> [Int]

toBits a = 
    if (a == 0) then []
    else [mod a 2] ++ toBits (div a 2)