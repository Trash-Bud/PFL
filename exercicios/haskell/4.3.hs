intercalar e ys = i2 e 0 ys

i2 e n ys =
    if (n == (length ys) + 1) then []
    else (insert e n ys) : (i2 e (n+1) ys)

insert e n ys = 
    if (ns == 0) then e : (ys)
    else (head ys) : (insert e (ns-1) (tail ys))
        where 
            ns = min n (length ys)