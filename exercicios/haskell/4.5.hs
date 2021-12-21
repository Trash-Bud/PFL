import Data.Char

cifraChave chave frase = map (chr) (zipWith (+) (take (length frase) (ch chave)) (map (ord) frase))

--faltaria impedir de ir pra caracteres q n são letras mas a parte imp esta

ch chave = (map (subtract  65) (map (ord) chave)) ++ (ch chave) 