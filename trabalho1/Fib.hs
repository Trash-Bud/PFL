import BigNumber

--calculates a number in the fibonacci sequence using recursion only
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec(n - 1) + fibRec(n - 2)

--calculates a number in the fibonacci sequence using memoized recursion
fibLista:: Int -> Integer
fibLista = (map fib' [0..] !!)                 
     where fib' 0 = 0                                                        
           fib' 1 = 1                                                        
           fib' n = fibLista (n-2) + fibLista (n-1) 

--infinite list of fibonacci numbers
fibs:: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

--calculates a number in the fibonacci sequence using memoized recursion and an infinite list
fibListaInfinita:: Integer -> Integer
fibListaInfinita n = (fibs !! n)

--calculates a number in the fibonacci sequence with BigNumbers using recursion only
fibRecBN :: BigNumber ->  BigNumber
fibRecBN (BigNumber {bn = [0], neg = False}) = posBN [0]
fibRecBN (BigNumber {bn = [1], neg = False}) = posBN [1]
fibRecBN l = somaBN (fibRecBN(subBN l (posBN [1]))) (fibRecBN(subBN l (posBN [2])))

--creates an infinite list of BigNumbers
infListBN :: [BigNumber]
infListBN = [scanner(show x)| x <- [0 .. ]]

--calculates a number in the fibonacci sequence with BigNumbers using memoized recursion 
fibListaBN :: BigNumber ->  BigNumber
fibListaBN n = (map fib' infListBN !! (read (output(n)) :: Int))                 
     where fib' (BigNumber {bn = [0], neg = False})  = posBN [0]                                                       
           fib' (BigNumber {bn = [1], neg = False}) = posBN [1]                                                     
           fib' n = somaBN (fibListaBN(subBN n (posBN [1]))) (fibListaBN(subBN n (posBN [2])))

--infinite list of fibonacci BigNumbers
fibsBN :: [BigNumber]
fibsBN = posBN [0] : posBN [1] : zipWith (somaBN) fibsBN (tail fibsBN)

--calculates a number in the fibonacci sequence with BigNumbers using memoized recursion and an infinite list
fibListaInfinitaBN :: BigNumber ->  BigNumber
fibListaInfinitaBN n = (fibsBN !! (read (output(n)) :: Int))