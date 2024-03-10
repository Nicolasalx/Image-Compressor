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

rotateImg :: Int -> Image PixelRGB8 -> Image PixelRGB8
rotateImg degrees img@(Image { imageWidth = width, imageHeight = height }) = runST $ do
    mimg <- M.newMutableImage height width
    let go x y
            | x >= width = go 0 (y + 1)
            | y >= height = M.unsafeFreezeImage mimg
            | degrees == 90 = do
                writePixel mimg
                  (height - y - 1)
                  x
                  (pixelAt img x y)
                go (x + 1) y
            | degrees == 270 = do
                writePixel mimg
                  y
                  (width - x - 1)
                  (pixelAt img x y)
                go (x + 1) y
            | otherwise = do
                writePixel mimg
                  (width - x - 1)
                  (height - y - 1)
                  (pixelAt img x y)
                go (x + 1) y
    go 0 0

rotateImg180 :: Image PixelRGB8 -> Image PixelRGB8
rotateImg180 img@(Image { imageWidth = width, imageHeight = height }) = runST $ do
  mimg <- M.newMutableImage width height
  let go x y
        | x >= width = go 0 (y + 1)
        | y >= height = M.unsafeFreezeImage mimg
        | otherwise = do
            writePixel mimg
              (width - x - 1)
              (height - y - 1)
              (pixelAt img x y)
            go (x + 1) y
  go 0 0

main :: IO ()
main = do
  args <- getArgs
  case args of
    [degreesStr, path, path'] -> do
      let degrees = read degreesStr :: Int
      eimg <- readImage path
      case eimg of
        Left err -> putStrLn ("Could not read image: " ++ err)
        Right (ImageRGB8 img) -> do
          if degrees == 90 || degrees == 270
            then savePngImage path' $ ImageRGB8 (rotateImg degrees img)
          else
            (savePngImage path' . ImageRGB8 . rotateImg180) img
        Right _ -> putStrLn "Unexpected pixel format"
    _ -> putStrLn "Usage: program input.png output.png"
