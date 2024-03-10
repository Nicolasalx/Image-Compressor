{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- GetFirstNColor
-}

module KMeans.GetFirstNColor (getFirstNColor, initCentroid) where
import DataStruct (Pixel(..), Centroid(..), createICent)

initCentroid :: [Int] -> [Centroid]
initCentroid (first : second : third : remain) =
    (createICent first second third) : initCentroid remain
initCentroid _ = []

containPixel :: [Centroid] -> Pixel -> Bool
containPixel ((Centroid centR centG centB) : remain) (Pixel _ _ r g b _)
    | (round centR) == r && (round centG) == g && (round centB) == b = True
    | otherwise = containPixel remain (Pixel 0 0 r g b 0)
containPixel [] _ = False

getFirstNColor :: Int -> [Pixel] -> [Centroid] -> [Int] -> [Centroid]
getFirstNColor 0 _ _ _ = []
getFirstNColor n [] _ rand = initCentroid (take (n * 3) rand)
getFirstNColor n ((Pixel _ _ r g b _) : remain) centroid rand
    | containPixel centroid (Pixel 0 0 r g b 0) == False =
        (createICent r g b) :
            getFirstNColor (n - 1) remain ((createICent r g b) : centroid) rand
    | otherwise = getFirstNColor n remain centroid rand
