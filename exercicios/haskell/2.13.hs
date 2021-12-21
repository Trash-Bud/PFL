mindiv :: Int -> Int

mindiv 1 = 1
mindiv a = [y | (x,y) <- zip (map (mod a) [2..a]) [2..], x == 0] !! 0

is_prime a =
    if (mindiv a == a) then True
    else False