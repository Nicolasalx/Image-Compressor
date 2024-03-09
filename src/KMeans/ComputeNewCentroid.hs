{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- ComputeNewCentroid
-}

module KMeans.ComputeNewCentroid (computeNewCentroid) where
import DataStruct (Centroid(..), Pixel(..), createICent)

addColor :: Centroid -> Centroid -> Centroid
addColor (Centroid r1 g1 b1) (Centroid r2 g2 b2) =
    (Centroid (r1 + r2) (g1 + g2) (b1 + b2))

sumColor :: [Pixel] -> Centroid
sumColor ((Pixel _ _ r g b _) : remain) = addColor (createICent r g b) (sumColor remain)
sumColor [] = (Centroid 0 0 0)

divCentroid :: Centroid -> Double -> Centroid
divCentroid _ 0 = (Centroid 0 0 0)
divCentroid (Centroid r g b) divisor = (Centroid
    (r / divisor) (g / divisor) (b / divisor))

computeAverageColor :: [Pixel] -> Centroid
computeAverageColor colorList =
    divCentroid (sumColor colorList) (fromIntegral (length colorList))

getPixelByIndex :: [Pixel] -> Int -> [Pixel]
getPixelByIndex ((Pixel x y r g b i) : remain) index
    | index == i = (Pixel x y r g b i) : getPixelByIndex remain index
    | otherwise = getPixelByIndex remain index
getPixelByIndex [] _ = []

computeNewCentroidHelper :: ([Centroid], [Pixel]) -> Int -> [Centroid]
computeNewCentroidHelper ((_ : remain), pixel) i =
    (computeAverageColor (getPixelByIndex pixel i)) : computeNewCentroidHelper (remain, pixel) (i + 1)
computeNewCentroidHelper ([], _) _ = []

computeNewCentroid :: ([Centroid], [Pixel]) -> [Centroid]
computeNewCentroid centroid = computeNewCentroidHelper centroid 0
