{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- ReassignColor
-}

module KMeans.ReassignColor (reassignColor, findClosestCentroid) where
import DataStruct (Pixel(..), Centroid(..), Color(..))
import KMeans.EuclidianDistance (euclidianDistance)

findIndexClosestCentroid :: [Centroid] -> Color -> Int -> Int -> Double -> Int
findIndexClosestCentroid (first : remain) color currentI minI minD
    | distance < minD = findIndexClosestCentroid remain color (currentI + 1) currentI distance
    | otherwise = findIndexClosestCentroid remain color (currentI + 1) minI minD
    where
        distance = euclidianDistance first color
findIndexClosestCentroid [] _ _ minI _ = minI

findClosestCentroid :: [Centroid] -> Color -> Int
findClosestCentroid centroid color = findIndexClosestCentroid centroid color 0 0 100000.0

reassignColor :: ([Centroid], [Pixel]) -> [Pixel]
reassignColor (centroid, ((Pixel x y r g b _) : remain)) = (Pixel x y r g b
    (findClosestCentroid centroid (Color r g b))) : reassignColor (centroid, remain)
reassignColor (_, []) = []
