{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- ParsingRealImg
-}

module Parsing.ParsingRealImg (parsingRealImg) where

import Parsing.ParsingArg (Args(..))
import Parsing.LibParsing(putError)
import DataStruct (Pixel(..))
import Codec.Picture

extractPixels :: Image PixelRGB8 -> [DataStruct.Pixel]
extractPixels img =
    [Pixel x y (fromIntegral r) (fromIntegral g) (fromIntegral b) |
        y <- [0..h-1], x <- [0..w-1],
    let PixelRGB8 r g b = pixelAt img x y]
    where
        (w, h) = (imageWidth img, imageHeight img)

checkImgPath :: Either String DynamicImage -> IO (Either String DynamicImage)
checkImgPath (Left err) = putError ("Error loading image") >> return (Left err)
checkImgPath img = return img

parseDynamicImage :: Either String DynamicImage -> IO [DataStruct.Pixel]
parseDynamicImage (Left _) = putError ("Failed to load image") >> return []
parseDynamicImage (Right (ImageRGB8 img)) = return (extractPixels img)
parseDynamicImage _ = putError "Failed to convert image to RGB8 format" >>
    return []

parsingRealImg :: Args -> IO [DataStruct.Pixel]
parsingRealImg (Args _ _ (Just filepath) True) = do
    eitherImg <- readImage filepath
    dynamicImage <- checkImgPath eitherImg
    parseDynamicImage dynamicImage
parsingRealImg _ = return []
