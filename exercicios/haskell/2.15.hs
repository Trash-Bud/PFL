interperse :: a-> [a] -> [a]

interperse c a = [if ((mod t 2) == 0) then (a!! (div t 2)) else c | t <- [0..(2*(length a)-2)]]