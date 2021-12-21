module BigNumber where

import Data.Char
import Data.List

--contains a field bn with the list of integers that are the bigNumber and a field neg which tells
--us if the number is negative or positive. 
data BigNumber = BigNumber { bn :: [Int], neg :: Bool}

--make the output function which is more easily readable the default output of BigNumber
instance Show BigNumber where
    show (BigNumber bn neg) = output (BigNumber bn neg)

-- turn a string into a BigNumber
scanner :: String -> BigNumber
scanner str = 
    if (str !! 0 == '-') then negScanBN str else posScanBN str

--turns a string into a negative BigNumber
negScanBN :: String -> BigNumber
negScanBN str = BigNumber {bn = removeLeadingZero[read (charToString a) :: Int| a <- (drop 1 str)], neg = True}

--turns a string into a positive BigNumber
posScanBN :: String -> BigNumber
posScanBN str = BigNumber {bn = removeLeadingZero[read (charToString a) :: Int| a <- str], neg = False}

--creates a negative BigNumber from a list of Int
negBN :: [Int] -> BigNumber
negBN n = BigNumber {bn = n, neg = True}
--creates a positive BigNumber from a list of Int
posBN :: [Int] -> BigNumber
posBN n = BigNumber {bn = n, neg = False}

--turns a BigNumber into a String
output :: BigNumber -> String
output l = 
    if (neg l) then '-' :[intToDigit a | a <- (removeLeadingZero(bn l))]
    else [intToDigit a | a <- (removeLeadingZero(bn l))]

--turns a char into a string
charToString :: Char -> String
charToString = (:"")

--evaluates if a >= b
bigger_or_equal :: [Int] -> [Int] -> Bool
bigger_or_equal a b =  
    if (az == bz) then True
    else if ((length  az) > (length bz)) then True
    else if ((length  az) < (length  bz)) then False
    else (
        if ((head az) == (head bz)) then bigger_or_equal (tail az) (tail bz)
        else if ((head az) > (head bz)) then True              
        else False
    ) 
        where az = removeLeadingZero a
              bz = removeLeadingZero b

--sums two lists with zipWith and makes sure that if they have differente sizes the extra
--elements remain by padding the smaller list with 0s
sumLists :: [Int] -> [Int] -> [Int]
sumLists a b = 
    if (length a == length b ) then zipWith (+) (reverse(a)) (reverse(b))
    else if (length a > length b) then zipWith (+) (reverse(a)) (reverse([0 | _ <- [1 .. ((length a) - (length b))]] ++ b))
    else zipWith (+) (reverse([0 | _ <- [1 .. ((length b) - (length a))]] ++ a)) (reverse(b))

--subtracts two lists with zipWith and makes sure that if they have differente sizes the extra
--elements remain by padding the smaller list with 0
subLists :: [Int] -> [Int] -> [Int]
subLists a b = 
    if (length a == length b ) 
        then 
            if (bigger_or_equal a b)
                then zipWith (-) (reverse(a)) (reverse(b))
                else zipWith (-) (reverse(b)) (reverse(a))
    else if (length a > length b) then zipWith (-) (reverse(a)) (reverse([0 | _ <- [1 .. ((length a) - (length b))]] ++ b))
    else zipWith (-) (reverse(b)) (reverse([0 | _ <- [1 .. ((length b) - (length a))]] ++ a))

--multiplies every element of b by every element of a
mulLists :: [Int] -> [Int] -> [Int]
mulLists a b = [x * y | x <- reverse(b), y <- reverse(a)]

--calculates carries for both sum and multiplication return them in a list
calculateCarries:: [Int] -> [Int]
calculateCarries a = [div x 10 | x <- a]

--calculates carries for the difference returning them in a list
calculateCarriesSub:: [Int] -> [Int]
calculateCarriesSub a = [if (x< 0) then 1 else 0 | x <- a]

--creates a list filled with zeros of the size of list a
empty :: [Int] -> [Int]
empty a = [0 | _<-[1.. (length a)]]

--creates a list filled with i zeros
empty_of_size :: Int -> [Int]
empty_of_size i = [0 | _<-[0..i-1]]

--adds carries in both multiplication and sum adding one zero on the right to
--make sure that they are added to the number after the one with a carry
addCarries :: [Int] -> [Int] -> [Int]
addCarries a b = zipWith (+) (a ++ [0]) (0 : b)

--subtracts carries in subtraction adding one zero on the right to
--make sure that they are subtracted to the number after the one that needed a carry
subtractCarries :: [Int] -> [Int] -> [Int]
subtractCarries a b = zipWith (-) (a ++ [0]) (0 : b)

--does a mod 10 of every element in the list making them lose their carries
removeCarries :: [Int] -> [Int]
removeCarries a = [mod x 10| x <- a]

--removes and adds carries for sum
--the function is recursive to acount for the cases where adding a carry to the number might cause it
--to have to carry to the one after
sumCarry  :: [Int] -> [Int] -> [Int]
sumCarry a b = 
    if ((calculateCarries k) == (empty k))
        then k
        else (sumCarry (reverse k) (empty k))
            where k = (addCarries (removeCarries(sumLists a b)) (calculateCarries (sumLists a b)))

--removes and subtracts carries for sub
--the function is recursive to acount for the cases where subtracting a carry to the number might cause it
--to have to get a carry from the digit after
subCarry  :: [Int] -> [Int] -> [Int]
subCarry a b = 
    if ((calculateCarriesSub k) == (empty k))
        then k
        else (subCarry (reverse k) (empty k))
            where k = (subtractCarries (removeCarries(subLists a b)) (calculateCarriesSub (subLists a b)))

--removes and adds carries for mul
--the function is recursive to acount for the cases where adding a carry to the number might cause it
--to have to carry to the digit after
mulCarry  :: [Int] -> [Int]
mulCarry a =
    if ((calculateCarries t) == (empty t)) then
        if (t !! (length t - 1) == 0) then init t
        else t
    else (mulCarry t)
        where t = (addCarries (removeCarries a) (calculateCarries a))

--splits a list in groups of n size
splitEvery :: Int -> [Int] -> [[Int]]
splitEvery _ [] = []
splitEvery n list = first : (splitEvery n rest)
  where
    (first,rest) = splitAt n list

--recursively adds all the results of the results of the multiplications padding with zeros to 
--correct the class of the numbers
sumOfMul :: [[Int]] -> Int -> [Int]
sumOfMul a i =
    if (i == ((length a) - 1)) then reverse ((empty_of_size i) ++ mulCarry(a!!i))
    else somaBN_int (reverse((empty_of_size i) ++ (mulCarry(a!!i)))) ((sumOfMul a (i+1)))

--gets the smallest ammount of the dividend that the devisor fits into
--returns in the format [[LowestFit],[RestOfTheNumber]] in  which lowestFit and RestOfTheNummber are a list of single digit numbers
-- separated by commas
getLowestFit :: [Int] -> [Int] -> [[Int]]
getLowestFit numerator denominator =
    if (not(bigger_or_equal numerator denominator)) then [[], numerator]
    else [k, drop (length k) numerator]
        where k = [take i numerator | i <- [1 .. (length numerator)], bigger_or_equal (take i numerator) denominator] !! 0

--after subtracting from the smallest ammount of the dividend that the devisor fits
--it joins the list together in one and removes any extra zeros
quotJoinRemainder :: [[Int]] -> [Int]
quotJoinRemainder l = 
    removeLeadingZero((l !! 0) ++ (l !! 1))

--calculates the quocient of a division by trying numbers until one of them works
--we use it for the smaller divisions we create from the larger one
calcQuot :: [Int] -> [Int] -> Int -> [Int]
calcQuot k b i =
    if ((mulBN_int b [i]) == k) then [i]
    else if (bigger_or_equal (mulBN_int b [i]) k) then [i - 1]
    else calcQuot k b (i+1)

--calculates de whole quocient recursively as well as return the remainder at the end
--the retun format is [Quocient,-1,Remainder] in which Quocient and Remainder are composed of single digit numbers
--separated by commas
assembleDivision :: [Int] -> [Int] -> [Int]
assembleDivision a b = 
    if (not(bigger_or_equal a b)) then (-1 : a)
    else if (not(null (t!!1))) then
        if (not (bigger_or_equal (l ++ [((t!!1) !! 0)]) b)) then (e ++ [0] ++ (assembleDivision k b))
        else (e ++ (assembleDivision k b))
    else (e ++ (assembleDivision k b))
        where k = quotJoinRemainder (l : (tail t))
              l = (subBN_int (t !! 0) (mulBN_int b e))
              t = getLowestFit a b
              e = calcQuot (t !! 0) b 0


--recursively removes extra zeros on the right of our list (int the case of lists that are bn from BigNumbers, they should
--come in reversed)
removeLeadingZero :: [Int] -> [Int]
removeLeadingZero a =
    if (a !! 0 == 0) then
        if (length a == 1)
            then [0]
            else removeLeadingZero (tail a)
    else a

--turn a and b into 2 positive BigNumbers for making intermediate sums of lists, returning also a list (the bn from the BigNumber)
somaBN_int :: [Int] -> [Int] -> [Int]
somaBN_int a b = bn (somaBN (posBN a) (posBN b))

--gets the final result of the sum, reverses it to make it have the correct orientation and decides 
--which signal the sum should have in the end (as well as if it is actually a sum or not)
somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN a b =
    if (neg a /= neg b) then 
        if (neg a) then (subBN b (posBN (bn a)))
        else (subBN a (posBN (bn b)))
    else if (neg a) then negBN k 
    else posBN k
        where k = removeLeadingZero (reverse (sumCarry (bn a) (bn b)))

--turn a and b into 2 positive BigNumbers for making intermediate subtractions of lists, returning also a list (the bn from the BigNumber)
subBN_int :: [Int] -> [Int] -> [Int]
subBN_int a b = bn (subBN (posBN a) (posBN b))

--gets the final result of the subtractions, reverses it to make it
--have the correct orientation and decides which signal the subtraction should have in the end 
--(as well as if it is a subtraction at all)
subBN :: BigNumber -> BigNumber -> BigNumber
subBN a b =
    if (neg a /= neg b) then 
        if (neg a) then somaBN a (negBN (bn b))
        else somaBN a (posBN (bn b))
    else if (bigger_or_equal (bn a) (bn b)) then 
        if (neg a) then (negBN k) -- (-a - (-b)) = neg
        else (posBN k) -- (a - (+ b)) = pos
    else if (neg b) then posBN k else negBN k -- (-a - (-b)) = pos  (a - (+b)) = neg
        where k = removeLeadingZero (reverse (subCarry (bn a) (bn b)))


--turn a and b into 2 positive BigNumbers for making intermediate multiplications of lists, returning also a list (the bn from the BigNumber)
mulBN_int :: [Int] -> [Int] -> [Int]
mulBN_int a b = bn (mulBN (posBN a) (posBN b))

--gets the final result of the multiplication and decides which signal the subtraction should have in the end.
mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN a b = 
    if (neg a == neg b) then posBN k
    else negBN k
        where k = removeLeadingZero (sumOfMul (splitEvery (length (bn a)) (mulLists (bn a) (bn b))) 0)

--gets the final result of the division (Quocient, Remainder) and decides which signal the Quocient should have in the end.
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN a b = 
    if (neg a == neg b) then 
        if ((bn b) == (bn a)) then (posBN([1]), posBN ([0]))
        else if (bigger_or_equal (bn b) (bn a)) then (posBN([0]), a)
        else (posBN(fst w), posBN (tail (snd w)))
    else
        if ((bn b) == (bn a)) then (negBN([1]), posBN ([0]))
        else if (bigger_or_equal (bn b) (bn a)) then (posBN([0]), somaBN b a)
        else (negBN (fst w), posBN (tail (snd w)))
            where w = break (-1==) (assembleDivision (bn a) (bn b))

--calls divBN to get the reult of the division only if the devisor is not 0 in which case it does nothing.
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
safeDivBN a b 
    | (bn b == empty (bn b)) = Nothing 
    | otherwise = Just (divBN a b)