--
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- compression
--

module Compression where
import System.Random (randomRIO)

data Vector3 = Vector3 Int Int Int
    deriving (Show)

data Color = Color Int Int Int
    deriving (Show, Eq)

data Centroid = Centroid Int Int Int
    deriving (Show, Eq)

-- euclidian distance between 2 vector

sq :: Int -> Double
sq x = fromIntegral (x * x)

euclidianDistance :: Centroid -> Color -> Double
euclidianDistance (Centroid va1 vb1 vc1) (Color va2 vb2 vc2) =
    sqrt (sq (va1 - va2) + sq (vb1 - vb2) + sq (vc1 - vc2))

-- -- max distance

-- findSmallest :: Vector3 -> Vector3 -> (Vector3, Double) -> (Vector3, Double)
-- findSmallest vec cmpvec smallest
--     | (euclidianDistance vec cmpvec) < (snd smallest) = (vec, euclidianDistance vec cmpvec)
--     | otherwise = smallest

-- smallestDistance :: [Vector3] -> Vector3 -> (Vector3, Double) -> (Vector3, Double)
-- smallestDistance (first : remain) vec smallest = smallestDistance remain vec (findSmallest first vec smallest)
-- smallestDistance [] _ smallest = smallest

-- ! ----------------------------------
initCentroid :: [Int] -> [Centroid]
initCentroid (first : second : third : remain) =
    (Centroid first second third) : initCentroid remain
initCentroid _ = []

createRandomList :: Int -> IO [Int]
createRandomList 0 = return []
createRandomList nbCentroid = do
    randomNb <- randomRIO (0, 255)
    remain <- createRandomList (nbCentroid - 1)
    return (randomNb : remain)
-- ! ----------------------------------

cmpCentroidColor :: Centroid -> Color -> (Centroid, Double) -> (Centroid, Double)
cmpCentroidColor centroid color smallest
    | (euclidianDistance centroid color) < (snd smallest) = (centroid, euclidianDistance centroid color)
    | otherwise = smallest

findClosestCentroid :: [Centroid] -> Color -> (Centroid, Double) -> (Centroid, Double)
findClosestCentroid (first : remain) color smallest =
    findClosestCentroid remain color (cmpCentroidColor first color smallest)
findClosestCentroid [] _ smallest = smallest

-- ???

initCentroidAndColor :: [Centroid] -> [(Centroid, [Color])]
initCentroidAndColor centroidList = map (\centroid -> (centroid, [])) centroidList

cmpCentroid :: Centroid -> Color -> (Centroid, [Color]) -> (Centroid, [Color])
cmpCentroid centroid color (currentCentroid, currentColor)
    | currentCentroid == centroid = (currentCentroid, color : currentColor)
    | otherwise = (currentCentroid, currentColor)

appendColorToCentroid :: Centroid -> Color -> [(Centroid, [Color])] -> [(Centroid, [Color])]
appendColorToCentroid centroid color cluster = map (cmpCentroid centroid color) cluster

assignDataPoint :: [Centroid] -> [Color] -> [(Centroid, [Color])] -> [(Centroid, [Color])]
assignDataPoint centroid (first : remain) cluster =
    assignDataPoint centroid remain (appendColorToCentroid (fst (findClosestCentroid centroid first ((Centroid 0 0 0), 10000))) first cluster)

    -- For Each Color:
        -- Find ClosestCentroid for a Given Color
        -- Add Color to the Centroid list
assignDataPoint _ [] cluster = cluster


-- assignDataPoint [(Centroid 33 18 109)] [(Color 34 18 112)] (initCentroidAndColor $1)

startKMeans :: Int -> Int -> [Color] -> IO ()
startKMeans nbCluster limit color = do
    randomList <- createRandomList (nbCluster * 3)
    let centroid = initCentroid randomList
    print (assignDataPoint (centroid) color (initCentroidAndColor centroid))
