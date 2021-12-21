palavras :: String -> [String]
    
palavras s = foldr (\x acc -> if (acc == [] ) then [x] : acc else if (x == ' ') then [] :acc else (x : (acc !! 0)) : (tail acc)) [] s