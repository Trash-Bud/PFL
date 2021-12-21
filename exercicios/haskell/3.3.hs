zipWithrec :: (a -> b -> c) -> [a] -> [b] -> [c]

zipWithrec a b c =
    if (null b || null c) then []
    else [a (head b) (head c)] ++ (zipWithrec a (tail b) (tail c))
    