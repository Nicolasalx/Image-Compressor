{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- ExportInPng
-}

module KMeans.ExportInPng (exportInPng) where
import DataStruct (Pixel(..), Centroid(..))

-- Centroid -> Cluster
-- For in list cluster
-- Replace Color dans le pixel par celle du cluster

exportInPng :: ([Centroid], [Pixel]) -> IO ()
exportInPng pixel = print (pixel)
