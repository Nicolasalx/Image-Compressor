{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- FilldataStruct
-}

module Parsing.FillDataStruct(fillDataStruct, checkDataStruct, processEntry) where
import DataStruct (Pixel(..))
import System.Exit

processEntry :: [[Int]] -> [Pixel]
processEntry entry
  | [[x, y], [r, g, b]] <- entry = [Pixel x y r g b 0]
  | otherwise = error "Invalid entry"

checkDataStruct :: Maybe [Pixel] -> IO [Pixel]
checkDataStruct Nothing = exitWith (ExitFailure 84)
checkDataStruct (Just data') = return data'

fillDataStruct :: Maybe [[[Int]]] -> Maybe [Pixel]
fillDataStruct Nothing = Nothing
fillDataStruct (Just array) = Just $ concatMap processEntry array




