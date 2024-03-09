{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- TestAlgo
-}

module TestKMeans.TestAlgo (testAlgoKMeans) where

import KMeans.EuclidianDistance (euclidianDistance, euclidianDistanceCent)
import KMeans.GetFirstNColor (initCentroid)
import DataStruct (Centroid(..), Color(..))
import Test.HUnit

testEuclidianDistance :: Test
testEuclidianDistance = TestList
    [ "Test case 1" ~:
        euclidianDistance (Centroid 1.0 1.0 1.0) (Color 0 0 0) ~?= sqrt 3
    , "Test case 2" ~:
        euclidianDistance (Centroid 0.0 0.0 0.0) (Color 1 1 1) ~?= sqrt 3
    , "Test case 3" ~:
        euclidianDistance (Centroid 0.0 0.0 0.0) (Color 0 0 0) ~?= 0.0
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


testAlgoKMeans :: Test
testAlgoKMeans = test [
        testEuclidianDistance,
        testEuclidianDistanceCent,
        testInitCentroid
    ]
