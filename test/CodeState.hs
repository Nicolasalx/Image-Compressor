{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- codeState
-}

module CodeState (TestCode(Success, Fail), printNameCode, printStateTest) where

data TestCode = Success | Fail

printNameCode :: String -> IO ()
printNameCode msg = putStrLn ("\n\ESC[4;1;34m" ++ replicate 30 ' ' ++
    msg ++ replicate 30 ' ' ++ "\ESC[0m")

printStateTest :: TestCode -> String -> IO ()
printStateTest Success msg = putStrLn ("\n\ESC[1;32m[" ++
    "SUCCESS" ++ "] -> " ++ msg ++ "\ESC[0m")
printStateTest Fail msg = putStrLn ("\n\ESC[1;31m[" ++ "FAIL" ++ "] -> "
    ++ msg ++ "\ESC[0m")
