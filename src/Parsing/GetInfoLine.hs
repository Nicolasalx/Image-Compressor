{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- GetInfoLine
-}

module Parsing.GetInfoLine (splitByCommas, extract, isACharOutsideParenthese) where
import Parsing.LibParsing(trim, getSafeInt)
import Parsing.ParsingArg (isPositive)
import Data.Char (isSpace)

extract :: String -> [String]
extract line = extractHelper line []

extractHelper :: String -> String -> [String]
extractHelper [] _ = []
extractHelper ('(':xs) _ = extractHelper xs ""
extractHelper (')':xs) acc = acc : extractHelper xs ""
extractHelper (x:xs) acc = extractHelper xs (acc ++ [x])

isACharOutsideParenthese :: String -> Bool
isACharOutsideParenthese = isACharOutsideParenthese' False

isACharOutsideParenthese' :: Bool -> String -> Bool
isACharOutsideParenthese' _ [] = False
isACharOutsideParenthese' True (')':rest) =
    isACharOutsideParenthese' False rest
isACharOutsideParenthese' _ ('(':rest) =
    isACharOutsideParenthese' True rest
isACharOutsideParenthese' False (c:rest) =
    not (isSpace c) || isACharOutsideParenthese' False rest
isACharOutsideParenthese' True (_:rest) =
    isACharOutsideParenthese' True rest

split :: (String, String) -> Maybe [Int]
split (word, rest)
    | Just val <- isPositive (getSafeInt (trim word)) =
        fmap (val :) (splitByCommas (drop 1 rest))
    | otherwise = Nothing

splitByCommas :: String -> Maybe [Int]
splitByCommas "" = Just []
splitByCommas s = split (break (==',') s)
