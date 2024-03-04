--
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- Main
--

module Main (main) where

import Parsing.ParsingArg (parsingArgs, checkArgValue)
import System.Environment

data Point = Point Int Int
data Color = Color Int Int Int

-- [(Point, Color)]

main :: IO ()
main = do
    args <- getArgs
    _ <- checkArgValue (parsingArgs args)
    print ("ok")
