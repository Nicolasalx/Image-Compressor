{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- Spec
-}

module Main (main) where

import Test.HUnit
import TestParsing.FileIsValid (testNonEmptyLines)
import TestParsing.DataStructIsValid (testsDataStruct)
import TestParsing.GetInfoLineIsValid (testsInfoLine)
import TestParsing.LibParsingTest (testLibParsing)
import TestParsing.ParsingArgIsOk (testParsingBasic)
import TestParsing.IsAParsingImg (testsParsingImg)
import TestKMeans.TestAlgo (testAlgoKMeans)
import CodeState (printNameCode, printStateTest, TestCode(Success, Fail))

data InfoTest = InfoTest Int Int
    deriving (Show)

execATest :: Test -> InfoTest -> IO InfoTest
execATest func (InfoTest total passed) = do
    Counts _ totalTests nb_errors nb_failures <- runTestTT func
    let passedTests = totalTests - nb_errors - nb_failures
        newPassed = passed + passedTests
    if nb_errors == 0 && nb_failures == 0
        then printStateTest Success "All tests have been passed !"
    else
        printStateTest Fail ("All the tests didn't pass:\n" ++
            show (totalTests - nb_errors - nb_failures) ++ " / " ++ show totalTests ++ " tests have been passed !")
    return (InfoTest (total + totalTests) newPassed)

printResultTest :: InfoTest -> IO ()
printResultTest (InfoTest total passed) = do
    let msg = "[" ++ show passed ++ "/" ++ show total ++ "] tests are OK !"
    putStrLn ("\n\ESC[4;1;32m" ++ replicate 25 '-' ++ " -> "
        ++ msg ++ " <-" ++ replicate 25 '-' ++ "\ESC[0m")

main :: IO ()
main = do
    let initialInfo = InfoTest 0 0
    printNameCode "Test Parsing Basic"
    updateInfo1 <- execATest testParsingBasic initialInfo
    printNameCode "Test Validity Lines"
    updateInfo2 <- execATest testNonEmptyLines updateInfo1
    printNameCode "Test Data Structure"
    updateInfo3 <- execATest testsDataStruct updateInfo2
    printNameCode "Test Info Line"
    updateInfo4 <- execATest testsInfoLine updateInfo3
    printNameCode "Test Lib Parsing"
    updateInfo5 <- execATest testLibParsing updateInfo4
    printNameCode "Test Parsing Image"
    updateInfo6 <- execATest testsParsingImg updateInfo5
    printNameCode "Test Algo KMeans"
    updateInfo7 <- execATest testAlgoKMeans updateInfo6
    printNameCode "Result of the tests"
    printResultTest updateInfo7
