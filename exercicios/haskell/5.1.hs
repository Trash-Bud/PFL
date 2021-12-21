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

parent :: String -> Bool

parent s = pile s (Stk [])

pile :: String -> Stack Char -> Bool

pile str s = 
    if (null str) then
        if (isEmpty s) then True
        else False
    else if ((head str) == '(' || (head str) == '[' || (head str) == '{') then pile (tail str) (push (head str) s)
    else if ((head str) == ')') then
        if (isEmpty s) then False
        else if ((top s) == '(') then pile (tail str) (pop s)
        else False
    else if ((head str) == ']') then
        if (isEmpty s) then False
        else if ((top s) == '[') then pile (tail str) (pop s)
        else False
    else if ((head str) == '}') then
        if (isEmpty s) then False
        else if ((top s) == '{') then pile (tail str) (pop s)
        else False
    else False
