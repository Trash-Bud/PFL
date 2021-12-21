myminimum :: Ord a => [a] -> a

myminimum list =
    if (length list == 1) then head list
    else if (head list < myminimum (tail list)) then head list
    else myminimum (tail list)

delete :: Eq a => a -> [a] -> [a]

delete a list =
    if (head list == a) then tail list
    else if (length list == 1) then [head list]
    else [head list] ++ (delete a (tail list))

ssort :: Ord a => [a] -> [a]

ssort list = 
    if (null list) then []
    else myminimum list : (ssort (delete (myminimum list) list) )