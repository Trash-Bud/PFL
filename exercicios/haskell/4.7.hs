data Arv a = Vazia | No a (Arv a) (Arv a) deriving Show

sumArv :: Num a => Arv a -> a

a = (No 11(No 3 (No 2 Vazia Vazia) (No 5 Vazia Vazia)) (No 19 (No 13 Vazia Vazia) (No 23 Vazia Vazia)))

sumArv Vazia = 0
sumArv (No a esq dir) = sumArv (esq) + a + sumArv (dir)

listar :: Arv a -> [a] 

listar Vazia = []
listar (No a esq dir) = listar (dir) ++ [a] ++ listar(esq)

nivel :: Int -> Arv a -> [a]

nivel n Vazia = []
nivel n (No a esq dir) = 
    if (n == 0) then [a]
    else (nivel (n-1) esq) ++ (nivel (n-1) dir)

mapArv :: (a -> b) -> Arv a -> Arv b

mapArv _ Vazia = Vazia
mapArv t (No a esq dir) = (No (t a) (mapArv t esq) (mapArv t dir))

inserir :: Ord a => a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No y esq dir)
    | x==y = No y esq dir -- já ocorre; não insere
    | x<y = No y (inserir x esq) dir -- insere à esquerda
    | x>y = No y esq (inserir x dir) -- insere à direita

construir :: Ord a => [a] -> Arv a
construir [] = Vazia
construir (x:xs) = inserir x (construir xs)

construirf xs = foldr inserir Vazia xs

maxnivel Vazia = 0
maxnivel (No a esq dir) = 1 + (max (maxnivel esq) (maxnivel dir))

mais_dir :: Arv a -> a
mais_dir (No x _ Vazia) = x
mais_dir (No _ _ dir) = mais_dir dir

maisEsq :: Arv a -> a
maisEsq (No x Vazia _) = x
maisEsq (No _ esq _) = maisEsq esq

remover :: Ord a => a -> Arv a -> Arv a

remover x Vazia = Vazia
remover x (No a Vazia dir)
    | (x == a) = dir
remover x (No a esq Vazia)
    | (x == a) = esq
remover x (No a esq dir)
    | (x < a) = No a (remover x esq) dir
    | (x > a) = No a esq (remover x dir)
    | (x == a) = No a esq (remover z dir)
        where z = mais_dir dir

    
