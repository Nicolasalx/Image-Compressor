{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- ExportInPng
-}

module KMeans.ExportInPng (exportInPng) where
import Codec.Picture (writePng)
import Codec.Picture.Types
import qualified Data.Sequence as Seq
import DataStruct (Pixel(..), Centroid(..))

centroidToPixel :: Centroid -> PixelRGB8
centroidToPixel (Centroid r g b) = PixelRGB8 (round r) (round g) (round b)

centroidToPixelRGB8 :: [Centroid] -> Seq.Seq PixelRGB8
centroidToPixelRGB8 centroids = Seq.fromList (map centroidToPixel centroids)

pixelToSeqPixel :: [DataStruct.Pixel] -> Seq.Seq DataStruct.Pixel
pixelToSeqPixel pixel = Seq.fromList pixel

getIPixel :: DataStruct.Pixel -> Int
getIPixel (Pixel _ _ _ _ _ i) = i

pixelToImage :: (Int, Int) -> (Seq.Seq PixelRGB8, Seq.Seq DataStruct.Pixel) -> Image PixelRGB8
pixelToImage (width, height) (centroid, pixel) =
    generateImage getPixelColor width height
    where
        getPixelColor x y = Seq.index centroid (getIPixel (Seq.index pixel (y * width + x)))

extractXY :: Maybe DataStruct.Pixel -> (Int, Int)
extractXY (Just (Pixel x y _ _ _ _)) = (x + 1, y + 1)
extractXY Nothing = (1, 1)

getImageSize :: Seq.Seq DataStruct.Pixel -> (Int, Int)
getImageSize pixel = extractXY (Seq.lookup (Seq.length pixel - 1) pixel)

createImage :: (Seq.Seq PixelRGB8, Seq.Seq DataStruct.Pixel) -> Image PixelRGB8
createImage (centroid, pixel) = pixelToImage (getImageSize pixel) (centroid, pixel)

getFileName :: String -> Int -> String
getFileName filename n =
    (take (length filename - 4) filename)
    ++ "_" ++ show n ++ "_color.png"

exportInPng :: ([Centroid], [DataStruct.Pixel]) -> Int -> String -> IO ()
exportInPng (centroid, pixel) n filePath =
    writePng (getFileName filePath n) (createImage (centroidToPixelRGB8 centroid, pixelToSeqPixel pixel))
