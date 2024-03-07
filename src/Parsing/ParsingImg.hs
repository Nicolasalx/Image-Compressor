{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- ParsingImg
-}

module Parsing.ParsingImg (parsingFile) where

import Parsing.ParsingArg (Args(..))
import Parsing.LibParsing(putError, countOccurrences)
import Parsing.FillDataStruct (fillDataStruct, checkDataStruct)
import Parsing.FileIsValid (isFileValid, nonEmptyLines)
import Parsing.GetInfoLine (splitByCommas, extract, isACharOutsideParenthese)
import DataStruct (Pixel(..))
import Parsing.ParsingRealImg (parsingRealImg)
import System.IO
import Control.Exception

parseInstruction :: String -> Maybe [[Int]]
parseInstruction line
    | commasCount /= 3 || openParenCount /= 2 || closeParenCount /= 2 ||
        isACharOutsideParenthese line = Nothing
    | otherwise = traverse splitByCommas $ extract line
    where
        commasCount = countOccurrences ',' line
        openParenCount = countOccurrences '(' line
        closeParenCount = countOccurrences ')' line

parseEachLine :: [String] -> Maybe [[[Int]]]
parseEachLine [] = Nothing
parseEachLine str = traverse parseInstruction str

handleFileOrError :: Either IOException Handle -> IO [Pixel]
handleFileOrError (Left e) = putError
    ("Error: " ++ show (e :: IOException)) >> return []
handleFileOrError (Right file) = do
    contents <- hGetContents file
    let eachLine = parseEachLine (nonEmptyLines contents)
    isFileValid eachLine
    hClose file
    checkDataStruct (fillDataStruct eachLine)

parsingFile :: Args -> IO [Pixel]
parsingFile (Args nbCol convLimit (Just filepath) True) =
    parsingRealImg (Args nbCol convLimit (Just filepath) True)
parsingFile (Args _ _ (Just filepath) False) = do
    fileOrError <- try $ openFile filepath ReadMode
    handleFileOrError fileOrError
parsingFile _ = return []
