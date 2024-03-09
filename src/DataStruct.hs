{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- Algo
-}

module DataStruct (Pixel(..), Centroid(..), Color(..), createICent) where

data Color = Color Int Int Int
    deriving (Eq)

data Pixel = Pixel Int Int Int Int Int Int
    deriving (Eq)

instance Show Pixel where
    show (Pixel x y r g b _) = "(" ++ show x ++ "," ++ show y ++ ") (" ++ show r ++ "," ++ show g ++ "," ++ show b ++ ")"

data Centroid = Centroid Double Double Double
    deriving (Eq)

instance Show Centroid where
    show (Centroid r g b) = "--\n(" ++ show (round r :: Int) ++ "," ++ show (round g :: Int) ++ "," ++ show (round b :: Int) ++ ")\n-"

createICent :: Int -> Int -> Int -> Centroid
createICent r g b = (Centroid
    (fromIntegral r) (fromIntegral g) (fromIntegral b))
