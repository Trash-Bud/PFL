module Conjunto (Conjunto, -- exportar o tipo
empty, member, insert, delete,
union, intersection, isEmpty, fromList, toList) where

data Conjunto a = Conj [a] deriving Show-- implementação usando listas

empty :: Conjunto a
empty = Conj []

member :: (Eq a) => a -> Conjunto a -> Bool
member a (Conj b) =
    if (null b) then False
    else if (a == head b) then True
    else member a (Conj (tail b))

insert ::(Eq a) => a -> Conjunto a -> Conjunto a
insert a (Conj b)
    | (not (member a (Conj b))) = (Conj (a : b))
    | otherwise = (Conj b)

delete ::(Eq a) => a -> Conjunto a -> Conjunto a
delete a (Conj b) = Conj (remove a b)

remove a b =
    if (null b) then []
    else if (a == head b) then tail b
    else (head b) : remove a (tail b) 

union ::(Eq a) => Conjunto a -> Conjunto a -> Conjunto a
union (Conj a) (Conj b) =
    if (null a) then Conj b
    else if (member (head a) (Conj b)) then union (Conj (tail a)) (Conj b)
    else union (Conj (tail a)) (Conj ((head a) : b))

intersection ::(Eq a) => Conjunto a -> Conjunto a -> Conjunto a
intersection (Conj a) (Conj b) = auxInter (Conj a) (Conj b) (Conj [])

auxInter (Conj a) (Conj b) (Conj c) =
    if (null a) then Conj c
    else if (member (head a) (Conj b)) then auxInter (Conj (tail a)) (Conj b) (Conj ((head a) :c))
    else auxInter (Conj (tail a)) (Conj b) (Conj c)

isEmpty :: Conjunto a ->Bool
isEmpty (Conj []) = True
isEmpty _ = False

fromList :: [a] -> Conjunto a
fromList a = Conj a

toList :: Conjunto a -> [a]
toList (Conj a) = a