{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- CreateRandomList
-}

module KMeans.CreateRandomList (createRandomList) where
import System.Random (randomRIO)

createRandomList :: Int -> IO [Int]
createRandomList 0 = return []
createRandomList nbCentroid = do
    randomNb <- randomRIO (0, 255)
    remain <- createRandomList (nbCentroid - 1)
    return (randomNb : remain)
