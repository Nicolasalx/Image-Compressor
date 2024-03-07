{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- Main
-}

module Main (main) where

import Parsing.ParsingArg (parsingArgs, checkArgValue, Args(..))
import Parsing.ParsingImg (parsingFile)
import KMeans.Compression (startKMeans)
import System.Environment

main :: IO ()
main = do
    args <- getArgs
    (Args nbCol convLimit fpImg isGraph) <- checkArgValue (parsingArgs args)
    arrayPointColour <- parsingFile (Args nbCol convLimit fpImg isGraph)
    startKMeans nbCol convLimit isGraph arrayPointColour
