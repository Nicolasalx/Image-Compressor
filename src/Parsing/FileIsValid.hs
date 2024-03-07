{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- FileIsValid
-}

module Parsing.FileIsValid (isFileValid, nonEmptyLines) where
import Parsing.LibParsing(putError)

handleValidityFile :: Bool -> IO ()
handleValidityFile False = putError "Error in parsing of the file!"
handleValidityFile True = pure()

isFileValid :: Maybe [[[Int]]] -> IO ()
isFileValid Nothing = putError "Error in parsing of the file!"
isFileValid (Just array) =
    handleValidityFile (all (\line -> length line == 2 &&
    length (line !! 0) == 2 && length (line !! 1) == 3 &&
    all (\x -> x >= 0 && x <= 255) (line !! 1)) array)

nonEmptyLines :: String -> [String]
nonEmptyLines = filter (not . null) . lines
