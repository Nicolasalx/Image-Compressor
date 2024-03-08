{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- GetInfoLineIsValid
-}

module TestParsing.GetInfoLineIsValid (testsInfoLine) where

import Parsing.GetInfoLine (extract, isACharOutsideParenthese)
import Test.HUnit

testExtract :: Test
testExtract = TestList
    [ "Test case 1" ~:
        extract "(Hello) World" ~?= ["Hello"]
    , "Test case 2" ~:
        extract "()" ~?= [""]
    , "Test case 3" ~:
        extract "a(b)c(d)e" ~?= ["b", "d"]
    ]

testIsACharOutsideParenthese :: Test
testIsACharOutsideParenthese = TestList
    [ "Test case 1" ~: isACharOutsideParenthese "(a)" ~?= False
    , "Test case 2" ~: isACharOutsideParenthese "( )" ~?= False
    , "Test case 3" ~: isACharOutsideParenthese "()" ~?= False
    , "Test case 4" ~: isACharOutsideParenthese "a" ~?= True
    , "Test case 5" ~: isACharOutsideParenthese "(a" ~?= False
    , "Test case 6" ~: isACharOutsideParenthese "a)" ~?= True
    ]

testsInfoLine :: Test
testsInfoLine = test [
        testExtract,
        testIsACharOutsideParenthese
    ]
