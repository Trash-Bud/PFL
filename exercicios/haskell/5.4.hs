module Set
(Set, empty, insert, member,
union) where

data Set a = Empty | Node a (Set a) (Set a) deriving Show

empty :: Set a
empty = Empty

insert :: Ord a => a -> Set a -> Set a
insert a Empty = Node a Empty Empty
insert a (Node b esq dir)
    | a == b = Node  b esq dir
    | a < b = Node b esq (insert a dir)
    | a > b = Node b (insert a esq)  dir

member :: Ord a => a -> Set a -> Bool
member a Empty = False
member a (Node b esq dir)
    | a == b = True
    | a < b = (member a dir)
    | a > b = (member a esq)


equal Empty Empty = True
equal Empty _ = False
equal (Node a esq dir) (Node b esq2 dir2)
    | (a /=b) = False
    | otherwise = (equal esq esq2) && (equal dir dir2) 
 
union :: Ord a => Set a -> Set a -> Set a

union Empty (Node a esq dir) = Node a esq dir
union (Node a esq dir) Empty = Node a esq dir
union Empty Empty = Empty
union (Node a esq dir) (Node b esq2 dir2) 
    | (equal (Node a esq dir) (Node b esq2 dir2) ) = (Node a esq dir)
    | member a (Node b esq2 dir2) = union (union esq (Node b esq2 dir2)) (union dir (Node b esq2 dir2))
    | otherwise =   union (union esq (insert a (Node b esq2 dir2))) (union dir (insert a (Node b esq2 dir2)))

