{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- ParsingImg
-}

module Parsing.ParsingImg (parsingFile) where

import Parsing.ParsingArg (Args(..))
import System.Directory (doesFileExist)
import System.IO
import System.Exit

extract :: String -> [String]
extract line
    | null begin = []
    | otherwise = part : extract rest
    where
        begin = dropWhile (/= '(') line
        after = tail begin
        part = takeWhile (/= ')') after
        rest = drop (length part + 1) after

parseInstruction :: String -> [String]
parseInstruction line = extract line

parseEachLine :: [String] -> IO ()
parseEachLine [] = return ()
parseEachLine (x:xs) = do
    let instructions = parseInstruction x
    print instructions
    parseEachLine xs

putError :: String -> IO ()
putError errorMsg =
    hPutStrLn stderr ("\ESC[4;1;31m" ++ errorMsg ++ "\ESC[0m") >>
    exitWith (ExitFailure 84)

checkFilePath :: Bool -> IO ()
checkFilePath True = pure ()
checkFilePath False = putError "The filePath is not a path of a file!"

parsingFile :: Args -> IO ()
parsingFile (Args _ _ (Just filepath)) = do
    isAFile <- doesFileExist filepath
    checkFilePath isAFile

    file <- openFile filepath ReadMode
    contents <- hGetContents file
    parseEachLine (lines contents)
    hClose file
parsingFile _ = pure ()
