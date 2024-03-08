{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- FileIsValid
-}

module TestParsing.FileIsValid (testNonEmptyLines) where

import Parsing.FileIsValid (nonEmptyLines)
import Test.HUnit

testNonEmptyLines :: Test
testNonEmptyLines = TestList
    [ "Test case 1" ~:
        nonEmptyLines "Hello\n\nWorld\n" ~?= ["Hello", "World"]
    , "Test case 2" ~:
        nonEmptyLines "Line1\nLine2\n" ~?= ["Line1", "Line2"]
    , "Test case 3" ~:
        nonEmptyLines "\n\n\n" ~?= []
    , "Test case 4" ~:
        nonEmptyLines "SingleLine" ~?= ["SingleLine"]
    ]
