{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- LibParsingTest
-}

module TestParsing.LibParsingTest (testLibParsing) where

import Parsing.LibParsing(trim, getSafeInt, countOccurrences)
import Test.HUnit

testTrim :: Test
testTrim = TestList
    [ "Test case 1" ~:
        trim "  Hello, World!   " ~?= "Hello, World!"
    , "Test case 2" ~:
        trim " \t\t " ~?= ""
    , "Test case 3" ~:
        trim "   \t\t\n\r  Hello, World!   \n\n\n" ~?= "Hello, World!"
    ]

testGetSafeInt :: Test
testGetSafeInt = TestList
    [ "Test case 1" ~: getSafeInt " 123 " ~?= Just 123
    , "Test case 2" ~: getSafeInt " 456abc " ~?= Nothing
    , "Test case 3" ~: getSafeInt " abc " ~?= Nothing
    , "Test case 4" ~: getSafeInt "" ~?= Nothing
    , "Test case 5" ~: getSafeInt "   " ~?= Nothing
    ]

testCountOccurrences :: Test
testCountOccurrences = TestList
    [ "Test case 1" ~:
        countOccurrences 'a' "banana" ~?= 3
    , "Test case 2" ~:
        countOccurrences ' ' "Hello, World!" ~?= 1
    , "Test case 3" ~:
        countOccurrences 'x' "" ~?= 0
    , "Test case 4" ~:
        countOccurrences '1' "1234567890" ~?= 1
    ]

testLibParsing :: Test
testLibParsing = test [
        testTrim,
        testGetSafeInt,
        testCountOccurrences
    ]