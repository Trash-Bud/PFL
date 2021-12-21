merge :: Ord a => [a] -> [a] -> [a]

merge a b =
    if (null a && null b) then []
    else if (null a) then (head b) : (merge a (tail b))
    else if (null b) then (head a) : (merge (tail a) b)
    else if (head a > head b) then head b : (merge a (tail b))
    else head a : (merge (tail a) b)

metades list = [[ list !! x | x <- [0..((div (length list) 2)-1)]], [ list !! x | x <- [((div (length list) 2))..((length list) - 1)]]]

msort :: Ord a => [a] -> [a]

msort [] = []
msort list =
    if ((length list) == 1) then list
    else if ((length list) == 2) then
        if (head list > last list) then [last list, head list]
        else list
    else merge (msort (head (metades list)))  (msort (last (metades list)))