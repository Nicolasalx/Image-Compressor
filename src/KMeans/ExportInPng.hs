{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- ExportInPng
-}

module KMeans.ExportInPng (exportInPng) where
import DataStruct (Pixel(..), Centroid(..))
import Codec.Picture (writePng)
import Codec.Picture.Types

-- Centroid -> Cluster
-- For in list cluster
-- Replace Color dans le pixel par celle du cluster

centroidToPixelRGB8 :: Centroid -> PixelRGB8
centroidToPixelRGB8 (Centroid r g b) = PixelRGB8 (round r) (round g) (round b)

pixelsToImage :: Int -> Int -> ([Centroid], [DataStruct.Pixel]) -> Image PixelRGB8
pixelsToImage width height pixels =
    generateImage pixelGenerator width height
    where
        pixelGenerator x y =
            let (Pixel _ _ _ _ _ i) = (snd pixels) !! (y * width + x)
            in centroidToPixelRGB8 ((fst pixels) !! i)

getSizeX :: DataStruct.Pixel -> Int
getSizeX (Pixel x _ _ _ _ _) = x

getSizeY :: DataStruct.Pixel -> Int
getSizeY (Pixel _ y _ _ _ _) = y

exportInPng :: ([Centroid], [DataStruct.Pixel]) -> String -> IO ()
exportInPng pixel filePath =
    writePng ("output_" ++ filePath) (pixelsToImage ((getSizeX (last (snd (pixel)))) + 1) ((getSizeY (last (snd (pixel)))) + 1) pixel)
