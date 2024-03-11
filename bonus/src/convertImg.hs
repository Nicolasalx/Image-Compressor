{-
-- EPITECH PROJECT, 2024
-- bonus
-- File description:
-- convertImg
-}

import Codec.Picture
import Control.Monad
import Control.Monad.ST
import System.Environment (getArgs)
import System.FilePath (replaceExtension)
import qualified Codec.Picture.Types as M

data ImgFormat = Bmp | Jpg | Png | Tiff

main :: IO ()
main = do
  [ext, path] <- getArgs
  case fromExt ext of
    Nothing -> putStrLn "Bad format!"
    Just fmt -> convertImg fmt path

convertImg
    :: ImgFormat
    -> FilePath
    -> IO ()
convertImg fmt path = do
    eimg <- readImage path
    case eimg of
      Left err -> putStrLn ("Could not read image: " ++ err)
      Right img ->
        (case fmt of
            Bmp -> saveBmpImage
            Jpg -> saveJpgImage 100
            Png -> savePngImage
            Tiff -> saveTiffImage)
        (replaceExtension path (toExt fmt))
        img

toExt :: ImgFormat -> String
toExt Bmp = "bmp"
toExt Jpg = "jpeg"
toExt Png = "png"
toExt Tiff = "tiff"

fromExt :: String -> Maybe ImgFormat
fromExt "bmp" = Just Bmp
fromExt "jpeg"= Just Jpg
fromExt "png" = Just Png
fromExt "tiff" = Just Tiff
fromExt _ = Nothing
