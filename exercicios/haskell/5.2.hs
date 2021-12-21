module Stack (Stack, -- exportar o tipo
push, pop, top, -- e as operações
empty, isEmpty) where

data Stack a = Stk [a] -- implementação usando listas

push :: a -> Stack a -> Stack a
push x (Stk xs) = Stk (x:xs)

pop :: Stack a -> Stack a
pop (Stk (_:xs)) = Stk xs
pop _ = error "Stack.pop: empty stack"

top :: Stack a -> a
top (Stk (x:_)) = x
top _ = error "Stack.top: empty stack"

empty :: Stack a
empty = Stk []

isEmpty :: Stack a -> Bool
isEmpty (Stk [])= True
isEmpty (Stk _) = False

calcular :: String -> Float
calcular str = top (calc (Stk []) str)

calc :: Stack Float -> String -> Stack Float

calc s str = calc1 s (words str)

calc1 :: Stack Float -> [String] -> Stack Float
calc1 s str =
    if (null str) then s
    else if ((head str) == "+") then calc1 (push ((top s) + (top (pop s)))  (pop (pop s))) (tail str)
    else if ((head str) == "-") then calc1 (push ((top s) - (top (pop s)))  (pop (pop s))) (tail str)
    else if ((head str) == "*") then calc1 (push ((top s) * (top (pop s)))  (pop (pop s))) (tail str) 
    else if ((head str) == "/") then calc1 (push ((top s) / (top (pop s)))  (pop (pop s))) (tail str) 
    else calc1 (push (read (head str) :: Float) s) (tail str)


calcularPrint :: String -> IO()

calcularPrint str = print (calcular str)

main :: IO ()
main = do
    putStrLn ("Insert an expression in RPN notation")
    expression <- getLine
    calcularPrint expression