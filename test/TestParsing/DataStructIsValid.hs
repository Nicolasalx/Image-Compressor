{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- DataStructIsValid
-}

module TestParsing.DataStructIsValid (testsDataStruct) where

import Parsing.FillDataStruct (fillDataStruct, processEntry)
import DataStruct (Pixel(..))
import Test.HUnit

testFillDataStruct :: Test
testFillDataStruct = TestList
    [ "FillDataStruct with empty list" ~:
        fillDataStruct Nothing ~?= Nothing
    , "FillDataStruct with valid array" ~:
        fillDataStruct (Just [[[1,2],[255,0,0]],[[3,4],[0,255,0]]]) ~?=
            Just [Pixel 1 2 255 0 0, Pixel 3 4 0 255 0]
    ]

testProcessEntry :: Test
testProcessEntry = TestList
    [ "ProcessEntry with valid entry" ~:
        processEntry [[1,2],[255,0,0]] ~?= [Pixel 1 2 255 0 0]
    ]

testsDataStruct :: Test
testsDataStruct = test [
        testProcessEntry,
        testFillDataStruct
    ]

