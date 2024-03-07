{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- Algo
-}

module DataStruct (Pixel(..)) where

data Pixel = Pixel Int Int Int Int Int
    deriving (Eq)

instance Show Pixel where
    show (Pixel x y r g b) = "(" ++ show x ++ "," ++ show y ++ ") (" ++ show r ++ "," ++ show g ++ "," ++ show b ++ ")"
