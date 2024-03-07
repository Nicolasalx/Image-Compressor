{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- Main
-}

module Main (main) where

import Parsing.ParsingArg (parsingArgs, checkArgValue)
import Parsing.ParsingImg (parsingFile)
import System.Environment

main :: IO ()
main = do
    args <- getArgs
    cmdArgs <- checkArgValue (parsingArgs args)
    arrayPointColour <- parsingFile cmdArgs
    print arrayPointColour
