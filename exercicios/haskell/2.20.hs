insert ::Ord a => a -> [a] -> [a]

insert a list = 
    if (null list) then [a]
    else if (head list > a) then a : list
    else (head list) : insert a (tail list)

isort :: Ord a => [a] -> [a]

isort [] = []
isort list =
    if ( length list == 1) then list
    else insert (head list) (isort (tail list)) 