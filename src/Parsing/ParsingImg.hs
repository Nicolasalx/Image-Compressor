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
import System.IO
import System.Directory (doesFileExist)

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
parseEachLine = traverse parseInstruction

checkFilePath :: Bool -> IO ()
checkFilePath True = pure ()
checkFilePath False = putError "The filePath is not a path of a file!"

parsingFile :: Args -> IO [Pixel]
parsingFile (Args _ _ (Just filepath)) = do
    isAFile <- doesFileExist filepath
    checkFilePath isAFile
    file <- openFile filepath ReadMode
    contents <- hGetContents file
    let eachLine = parseEachLine (nonEmptyLines contents)
    isFileValid eachLine
    hClose file
    checkDataStruct (fillDataStruct eachLine)
parsingFile _ = return []
