{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- LibParsing
-}

module Parsing.LibParsing(putError, trim, getSafeInt, countOccurrences) where
import System.Exit
import Data.Char (isSpace)
import System.IO
import Text.Read (readMaybe)

putError :: String -> IO ()
putError errorMsg =
    hPutStrLn stderr ("\ESC[4;1;31m" ++ errorMsg ++ "\ESC[0m") >>
    exitWith (ExitFailure 84)

trim :: String -> String
trim = f . f
    where f = reverse . dropWhile isSpace

getSafeInt :: String -> Maybe Int
getSafeInt str
    | all isSpace str || null (trim str) = Nothing
    | otherwise = readMaybe (trim str)

countOccurrences :: Char -> String -> Int
countOccurrences c = length . filter (== c)
