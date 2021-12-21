m_maximum, m_manimum :: Ord a => [a] -> a

m_maximum a = foldl1 (max) a
m_manimum a = foldl1 (min) a