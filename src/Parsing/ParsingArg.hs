{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- ParsingArg
-}

module Parsing.ParsingArg (parsingArgs, checkArgValue, Args(..), isPositive) where
import Text.Read (readMaybe)
import System.Exit

data Args = Args
    {
        nbColors:: Maybe Int,
        convergLimit:: Maybe Double,
        filepathImg:: Maybe String
    } deriving (Show, Eq)

defaultArgs :: Args
defaultArgs =
    Args {
        nbColors = Nothing,
        convergLimit = Nothing,
        filepathImg = Nothing
    }

isPositive :: (Num a, Ord a) => Maybe a -> Maybe a
isPositive (Just value)
    | value < 0 = Nothing
    | otherwise = Just value
isPositive Nothing = Nothing

checkArgValue :: Args -> IO Args
checkArgValue ((Args Nothing _ _)) = exitWith (ExitFailure 84)
checkArgValue ((Args _ Nothing _)) = exitWith (ExitFailure 84)
checkArgValue ((Args _ _ Nothing)) = exitWith (ExitFailure 84)
checkArgValue args = return args

getOpts :: Args -> [String] -> Args
getOpts args ("-n" : second : remain) =
    getOpts (args {nbColors = isPositive (readMaybe second)}) remain
getOpts args ("-l" : second : remain) =
    getOpts (args {convergLimit = isPositive (readMaybe second)}) remain
getOpts args ("-f" : second : remain) =
        getOpts (args {filepathImg = Just second}) remain
getOpts args [] = args
getOpts args _ = args

parsingArgs :: [String] -> Args
parsingArgs args = getOpts defaultArgs args
