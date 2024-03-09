{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- PrintKMeans
-}

module KMeans.PrintKMeans (printKMeans) where
import DataStruct (Pixel(..), Centroid(..))

printKMeansColor :: [Pixel] -> Int -> IO ()
printKMeansColor ((Pixel x y r g b i) : remain) index
    | index == i = print (Pixel x y r g b i) >> printKMeansColor remain index
    | otherwise = printKMeansColor remain index
printKMeansColor [] _ = return ()

printKMeansHelper :: ([Centroid], [Pixel]) -> Int -> IO ()
printKMeansHelper (first : remain, color) index =
    print first >> printKMeansColor color index >> printKMeansHelper (remain, color) (index + 1)
printKMeansHelper ([], _) _ = return ()

printKMeans :: ([Centroid], [Pixel]) -> IO ()
printKMeans centroid = printKMeansHelper centroid 0
