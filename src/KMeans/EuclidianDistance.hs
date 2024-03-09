{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- EuclidianDistance
-}

module KMeans.EuclidianDistance (euclidianDistance, euclidianDistanceCent) where
import DataStruct (Centroid(..), Color(..))

sq :: Double -> Double
sq x = (x * x)

euclidianDistance :: Centroid -> Color -> Double
euclidianDistance (Centroid va1 vb1 vc1) (Color va2 vb2 vc2) =
    sqrt (sq (va1 - (fromIntegral va2)) +
        sq (vb1 - (fromIntegral vb2)) +
        sq (vc1 - (fromIntegral vc2)))

euclidianDistanceCent :: Centroid -> Centroid -> Double
euclidianDistanceCent (Centroid va1 vb1 vc1) (Centroid va2 vb2 vc2) =
    sqrt (sq (va1 - va2) + sq (vb1 - vb2) + sq (vc1 - vc2))
