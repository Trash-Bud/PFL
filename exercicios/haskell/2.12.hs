import Data.Char

forte :: String -> Bool

forte st = 
    if (length st) < 8 then False
    else (or [ isLower  x |  x <- st]) && (or [ isDigit  x |  x <- st]) && (or [ isUpper  x |  x <- st])