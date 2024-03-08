{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- ParsingArgIsOk
-}

module TestParsing.ParsingArgIsOk (testParsingBasic) where

import Parsing.ParsingArg (Args(..), isPositive, defaultArgs, isStrictlyPositive)
import Test.HUnit

testDefaultArgs :: Test
testDefaultArgs = TestCase $ do
    assertEqual "nbColors should be Nothing"
        (nbColors defaultArgs :: Maybe Int) Nothing
    assertEqual "convergLimit should be Nothing"
        (convergLimit defaultArgs :: Maybe Double) Nothing
    assertEqual "filepathImg should be Nothing"
        (filepathImg defaultArgs :: Maybe String) Nothing
    assertEqual "isGraphical should be False"
        (isGraphical defaultArgs) False

testIsPositive :: Test
testIsPositive = TestList
    [ "Test case 1" ~: isPositive (Just 5 :: Maybe Int) ~?= Just 5
    , "Test case 2" ~: isPositive (Just (-5) :: Maybe Int) ~?= Nothing
    , "Test case 3" ~: isPositive (Nothing :: Maybe Int) ~?= Nothing
    ]

testIsStrictlyPositive :: Test
testIsStrictlyPositive = TestList
    [ "Test case 1" ~: isStrictlyPositive (Just 5 :: Maybe Int) ~?= Just 5
    , "Test case 2" ~: isStrictlyPositive (Just 0 :: Maybe Int) ~?= Nothing
    , "Test case 3" ~: isStrictlyPositive (Just (-5) :: Maybe Int) ~?= Nothing
    , "Test case 4" ~: isStrictlyPositive (Nothing :: Maybe Int) ~?= Nothing
    ]

testParsingBasic :: Test
testParsingBasic = test [
        testDefaultArgs,
        testIsPositive,
        testIsStrictlyPositive
    ]
