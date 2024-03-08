{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- IsAParsingImg
-}

module TestParsing.IsAParsingImg (testsParsingImg) where

import Parsing.ParsingImg (parseInstruction, parseEachLine)
import Test.HUnit

sampleLines :: [String]
sampleLines =
    [
        "(1,2,3,4),(5,6,7,8)"
        , "(9,10,11,12),(13,14,15,16)"
        , "(17,18,19,20),(21,22,23,24)"
    ]

testParseInstruction :: Test
testParseInstruction = TestList
    [
        "Test case 1" ~: parseInstruction "(1,2,3,4),(5,6,7,8)" ~?= Nothing
        , "Test case 2" ~: parseInstruction "(1,2,3,4),(5,6,7,8,9)" ~?= Nothing
        , "Test case 3" ~: parseInstruction "(1,2,3),(5,6,7,8)" ~?= Nothing
    ]

testParseEachLine :: Test
testParseEachLine = TestList
    [
        "Test case 1" ~: parseEachLine sampleLines ~?= Nothing
    ]

testsParsingImg :: Test
testsParsingImg = test [
        testParseInstruction,
        testParseEachLine
    ]
