{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- ParsingArg
-}

module Parsing.ParsingArg (parsingArgs, checkArgValue) where

import Text.Read (readMaybe)
import System.Exit

data Args = Args
    {
        nbColors:: Maybe Int,
        convergLimit:: Maybe Int,
        filepathImg:: Maybe String
    } deriving (Show, Eq)

defaultArgs :: Args
defaultArgs =
    Args {
        nbColors = Nothing,
        convergLimit = Nothing,
        filepathImg = Nothing
    }

checkArgValue :: Maybe Args -> IO (Maybe Args)
checkArgValue (Just (Args Nothing _ _)) = exitWith (ExitFailure 84)
checkArgValue (Just (Args _ Nothing _)) = exitWith (ExitFailure 84)
checkArgValue (Just (Args _ _ Nothing)) = exitWith (ExitFailure 84)
checkArgValue Nothing = exitWith (ExitFailure 84)
checkArgValue args = return args


isPositive :: Maybe Int -> Maybe Int
isPositive (Just value)
    | value < 0 = Nothing
    | otherwise = Just value
isPositive Nothing = Nothing

getOpts :: Args -> [String] -> Maybe Args
getOpts args ("-n" : second : remain) = getOpts (args {nbColors = isPositive (readMaybe second)}) remain
getOpts args ("-l" : second : remain) = getOpts (args {convergLimit = isPositive (readMaybe second)}) remain
getOpts args ("-f" : second : remain) = getOpts (args {filepathImg = Just second}) remain
getOpts args [] = Just args
getOpts _ _ = Nothing

parsingArgs :: [String] -> Maybe Args
parsingArgs args = getOpts defaultArgs args
