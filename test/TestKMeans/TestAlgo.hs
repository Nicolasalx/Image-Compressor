{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- TestAlgo
-}

module TestKMeans.TestAlgo (testAlgoKMeans) where

import KMeans.Compression (euclidianDistance,
    euclidianDistanceCent,
    initCentroid,
    cmpCentroidColor,
    findClosestCentroid,
    appendColorToCentroid,
    assignDataPoint,
    initCentroidList)
import DataStruct (Pixel(..), Centroid(..))
import Test.HUnit

testEuclidianDistance :: Test
testEuclidianDistance = TestList
    [ "Test case 1" ~:
        euclidianDistance (Centroid 1.0 1.0 1.0) (Pixel 0 0 0 0 0) ~?= sqrt 3
    , "Test case 2" ~:
        euclidianDistance (Centroid 0.0 0.0 0.0) (Pixel 1 1 1 1 1) ~?= sqrt 3
    , "Test case 3" ~:
        euclidianDistance (Centroid 0.0 0.0 0.0) (Pixel 0 0 0 0 0) ~?= 0.0
    ]

testEuclidianDistanceCent :: Test
testEuclidianDistanceCent = TestList
    [ "Test case 1" ~:
        euclidianDistanceCent (Centroid 1.0 1.0 1.0) (Centroid 0.0 0.0 0.0) ~?=
                sqrt 3
    , "Test case 2" ~: euclidianDistanceCent (Centroid 0.0 0.0 0.0)
        (Centroid 1.0 1.0 1.0) ~?= sqrt 3
    , "Test case 3" ~:
        euclidianDistanceCent (Centroid 0.0 0.0 0.0) (Centroid 0.0 0.0 0.0) ~?=
                0.0
    ]

testInitCentroid :: Test
testInitCentroid = TestList
    [ "Test case 1" ~:
        initCentroid [255, 128, 0, 100, 200, 50] ~?=
            [Centroid 255.0 128.0 0.0, Centroid 100.0 200.0 50.0]
    , "Test case 2" ~:
        initCentroid [0, 0, 0] ~?= [Centroid 0.0 0.0 0.0]
    , "Test case 3" ~:
        initCentroid [] ~?= ([] :: [Centroid])
    ]

testCmpCentroidColor :: Test
testCmpCentroidColor = TestList
    [ "Test case 1" ~:
        cmpCentroidColor (Centroid 1.0 1.0 1.0) (Pixel 0 0 0 0 0)
            ((Centroid 2.0 2.0 2.0), 1.0) ~?= ((Centroid 2.0 2.0 2.0), 1.0)
    , "Test case 2" ~:
        cmpCentroidColor (Centroid 0.0 0.0 0.0) (Pixel 1 1 1 1 1)
            ((Centroid 0.0 0.0 0.0), 0.0) ~?= ((Centroid 0.0 0.0 0.0), 0.0)
    , "Test case 3" ~:
        cmpCentroidColor (Centroid 2.0 2.0 2.0) (Pixel 0 0 0 0 0)
            ((Centroid 1.0 1.0 1.0), 0.5) ~?= ((Centroid 1.0 1.0 1.0), 0.5)
    ]

testFindClosestCentroid :: Test
testFindClosestCentroid = TestList
    [ "Test case 1" ~:
        findClosestCentroid [Centroid 1.0 1.0 1.0, Centroid 2.0 2.0 2.0]
            (Pixel 0 0 0 0 0) ((Centroid 3.0 3.0 3.0), 1.0) ~?=
            ((Centroid 3.0 3.0 3.0), 1.0)
    , "Test case 2" ~:
        findClosestCentroid [Centroid 0.0 0.0 0.0] (Pixel 1 1 1 1 1)
            ((Centroid 0.0 0.0 0.0), 0.0) ~?= ((Centroid 0.0 0.0 0.0), 0.0)
    , "Test case 3" ~:
        findClosestCentroid [] (Pixel 0 0 0 0 0) ((Centroid 1.0 1.0 1.0), 0.5) ~?=
            ((Centroid 1.0 1.0 1.0), 0.5)
    ]

testInitCentroidList :: Test
testInitCentroidList = TestList
    [ "Test case 1" ~:
        initCentroidList [Centroid 1.0 2.0 3.0, Centroid 4.0 5.0 6.0] ~?= [(Centroid 1.0 2.0 3.0, []), (Centroid 4.0 5.0 6.0, [])]
    , "Test case 2" ~:
        initCentroidList [Centroid 0.0 0.0 0.0] ~?= [(Centroid 0.0 0.0 0.0, [])]
    ]

testAppendColorToCentroid :: Test
testAppendColorToCentroid = TestList
    [ "Test case 1" ~:
        appendColorToCentroid (Centroid 1.0 2.0 3.0) (Pixel 0 0 0 0 0)
            [(Centroid 1.0 2.0 3.0, [])] ~?= [(Centroid 1.0 2.0 3.0,
            [Pixel 0 0 0 0 0])]
    , "Test case 2" ~:
        appendColorToCentroid (Centroid 0.0 0.0 0.0) (Pixel 1 1 1 1 1)
            [(Centroid 0.0 0.0 0.0, [])] ~?= [(Centroid 0.0 0.0 0.0,
            [Pixel 1 1 1 1 1])]
    ]

testAssignDataPoint :: Test
testAssignDataPoint = TestList
    [ "Test case 1" ~:
        assignDataPoint [Centroid 1.0 2.0 3.0, Centroid 4.0 5.0 6.0]
            [Pixel 0 0 0 0 0, Pixel 1 1 1 1 1] [] ~?= []
    , "Test case 2" ~:
        assignDataPoint [Centroid 0.0 0.0 0.0]
            [Pixel 1 1 1 1 1, Pixel 2 2 2 2 2] [] ~?= []
    ]

testAlgoKMeans :: Test
testAlgoKMeans = test [
        testEuclidianDistance,
        testEuclidianDistanceCent,
        testInitCentroid,
        testCmpCentroidColor,
        testFindClosestCentroid,
        testAppendColorToCentroid,
        testAssignDataPoint,
        testInitCentroidList
    ]
