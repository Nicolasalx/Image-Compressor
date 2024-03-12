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
    deriving (Eq)

chooseFormat :: ImgFormat -> (FilePath -> DynamicImage -> IO ())
chooseFormat Bmp = saveBmpImage
chooseFormat Jpg = saveJpgImage 100
chooseFormat Png = savePngImage
chooseFormat Tiff = saveTiffImage

readImgBefConv :: ImgFormat -> FilePath -> Either String DynamicImage -> IO ()
readImgBefConv _ _ (Left err) = putStrLn ("Could not read image: " ++ err)
readImgBefConv fmt path (Right img) = (chooseFormat fmt) (replaceExtension
    path (toExt fmt)) img

convertImg :: ImgFormat -> FilePath -> IO ()
convertImg fmt path = do
    eimg <- readImage path
    readImgBefConv fmt path eimg

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

convertImg' :: FilePath -> ImgFormat -> IO ()
convertImg' path fmt = convertImg fmt path

main :: IO ()
main = do
    [ext, path] <- getArgs
    maybe (putStrLn "Bad format!") (convertImg' path) (fromExt ext)
