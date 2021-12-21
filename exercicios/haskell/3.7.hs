clist a b = foldr (:) b a

myconcat a = foldr (++) [] a

myreverse :: [a] -> [a]
myreverse bs =  foldr (\x acc ->  acc ++ [x]) [] bs

myreversel :: [a] -> [a]
myreversel bs =  foldl (\acc x -> x : acc) [] bs
