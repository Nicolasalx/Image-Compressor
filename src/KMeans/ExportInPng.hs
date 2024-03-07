{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- ExportInPng
-}

module KMeans.ExportInPng (exportInPng) where
import DataStruct (Pixel(..), Centroid(..))

exportInPng :: [(Centroid, [Pixel])] -> IO ()
exportInPng pixel = print (pixel)
