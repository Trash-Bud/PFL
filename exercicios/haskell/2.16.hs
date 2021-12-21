algarismos :: Int ->[Int]
algarismos a = 
    if (a == 0) then []
    else [mod a 10] ++ algarismos (div a 10)

