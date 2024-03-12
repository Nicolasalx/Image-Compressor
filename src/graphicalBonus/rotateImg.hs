{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- rotateImg
-}

import Codec.Picture
import Control.Monad.ST
import qualified Codec.Picture.Types as M
import System.Environment
import Codec.Picture.Types (MutableImage)

writePixelMimg90 :: MutableImage s PixelRGB8 -> Int -> Int ->
    Int -> Image PixelRGB8 -> ST s ()
writePixelMimg90 mimg height y x img = writePixel mimg
                (height - y - 1)
                x
                (pixelAt img x y)

writePixelMimg180 :: MutableImage s PixelRGB8 -> Int -> Int ->
    Int -> Int -> Image PixelRGB8 -> ST s ()
writePixelMimg180 mimg height width y x img = writePixel mimg
                (width - x - 1)
                (height - y - 1)
                (pixelAt img x y)

writePixelMimg270 :: MutableImage s PixelRGB8 -> Int -> Int ->
    Int -> Image PixelRGB8 -> ST s ()
writePixelMimg270 mimg width y x img = writePixel mimg
                y
                (width - x - 1)
                (pixelAt img x y)

writeByDegrees :: Int -> MutableImage s PixelRGB8 -> Int -> Int ->
    Int -> Int -> Image PixelRGB8 -> ST s ()
writeByDegrees 90 mimg height _ y x img =
    writePixelMimg90 mimg height y x img
writeByDegrees 270 mimg _ width y x img =
    writePixelMimg270 mimg width y x img
writeByDegrees _ mimg height width y x img =
    writePixelMimg180 mimg height width y x img

rotateImg :: Int -> Image PixelRGB8 -> Image PixelRGB8
rotateImg degrees img@(Image { imageWidth = width, imageHeight = height }) =
        runST $ do
    mimg <- M.newMutableImage height width
    let go x y
            | x >= width = go 0 (y + 1)
            | y >= height = M.unsafeFreezeImage mimg
            | otherwise =
                writeByDegrees degrees mimg height width y x img >>
                go (x + 1) y
    go 0 0

rotateWithDegrees :: Either String DynamicImage -> Int -> FilePath -> IO ()
rotateWithDegrees (Left errMsg) _ _ = putStrLn ("Could not read image: "
    ++ errMsg)
rotateWithDegrees (Right (ImageRGB8 img)) degrees path' =
    savePngImage path' $ ImageRGB8 (rotateImg degrees img)
rotateWithDegrees (Right _) _ _ = putStrLn "Unexpected pixel format"

readImg :: String -> FilePath -> FilePath -> IO ()
readImg degreesStr path path' =
    readImage path >>= rotateWithDegrees' path' (read degreesStr)

rotateWithDegrees' :: FilePath -> Int -> Either String DynamicImage -> IO ()
rotateWithDegrees' path' degrees eimg =
    rotateWithDegrees eimg degrees path'

parseArgs :: [String] -> IO ()
parseArgs [degreesStr, path, path'] = readImg degreesStr path path'
parseArgs _ = putStrLn "Usage: program input.png output.png"

main :: IO ()
main = do
    args <- getArgs
    parseArgs args
