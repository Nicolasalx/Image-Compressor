--
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- compression
--

module Compression where
import System.Random (randomRIO)
import Debug.Trace

data Color = Color Int Int Int
    deriving (Eq)

instance Show Color where
    show (Color r g b) = "(" ++ show r ++ "," ++ show g ++ "," ++ show b ++ ")"

data Point = Point Int Int
    deriving (Eq)

instance Show Point where
    show (Point x y) = "(" ++ show x ++ "," ++ show y ++ ") "


data Centroid = Centroid Double Double Double
    deriving (Eq)

instance Show Centroid where
    show (Centroid r g b) = "--\n(" ++ show (round r) ++ "," ++ show (round g) ++ "," ++ show (round b) ++ ")\n-"

-- euclidian distance between 2 vector

sq :: Double -> Double
sq x = (x * x)

euclidianDistance :: Centroid -> Color -> Double
euclidianDistance (Centroid va1 vb1 vc1) (Color va2 vb2 vc2) =
    sqrt (sq (va1 - (fromIntegral va2)) + sq (vb1 - (fromIntegral vb2)) + sq (vc1 - (fromIntegral vc2)))

euclidianDistanceCent :: Centroid -> Centroid -> Double
euclidianDistanceCent (Centroid va1 vb1 vc1) (Centroid va2 vb2 vc2) =
    sqrt (sq (va1 - va2) + sq (vb1 - vb2) + sq (vc1 - vc2))

-- ! ----------------------------------
initCentroid :: [Int] -> [Centroid]
initCentroid (first : second : third : remain) =
    (Centroid (fromIntegral first) (fromIntegral second) (fromIntegral third)) : initCentroid remain
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

-- !

addColor :: Centroid -> Centroid -> Centroid
addColor (Centroid r1 g1 b1) (Centroid r2 g2 b2) = (Centroid (r1 + r2) (g1 + g2) (b1 + b2))

sumColor :: [Color] -> Centroid
sumColor ((Color r g b) : remain) = addColor (Centroid (fromIntegral r) (fromIntegral g) (fromIntegral b)) (sumColor remain)
sumColor [] = (Centroid 0 0 0)

divCentroid :: Centroid -> Int -> Centroid
divCentroid _ 0 = (Centroid 0 0 0)
divCentroid (Centroid r g b) divisor = (Centroid (r / (fromIntegral divisor)) (g / (fromIntegral divisor)) (b / (fromIntegral divisor)))

computeAverageColor :: [Color] -> Centroid
computeAverageColor colorList = divCentroid (sumColor colorList) (length colorList)

-- ! need to return a double of
-- computeNewCentroid :: [(Centroid, [Color])] -> ([(Centroid, [Color])], Double)
-- computeNewCentroid (first : remain) =
--     (computeAverageColor (snd first), snd first) : computeNewCentroid remain
-- computeNewCentroid [] = ([], convergence)

computeNewCentroid :: [(Centroid, [Color])] -> ([(Centroid, [Color])], Double)
computeNewCentroid (first : remain) =
    let prevCentroid = fst first
        newCentroid = computeAverageColor (snd first)
        (newCluster, maxDistance) = computeNewCentroid remain
    in ((newCentroid, (snd first)) : newCluster, max (euclidianDistanceCent prevCentroid newCentroid) maxDistance)
computeNewCentroid [] = ([], 0.0)

-- !

extractCentroidList :: [(Centroid, [Color])] -> [Centroid]
extractCentroidList (first : remain) = (fst first) : extractCentroidList remain
extractCentroidList [] = []

extractColorList :: [(Centroid, [Color])] -> [Color]
extractColorList (first : remain) = (snd first) ++ extractColorList remain
extractColorList [] = []

checkLimit :: ([(Centroid, [Color])], Double) -> Double -> [(Centroid, [Color])]
checkLimit centroidColor limit
    | (snd centroidColor) > limit = kmeansLoop (fst centroidColor) limit
    | otherwise = fst centroidColor

removeColor :: [(Centroid, [Color])] -> [(Centroid, [Color])]
removeColor ((centroid, _) : remain) = (centroid, []) : removeColor remain
removeColor [] = []

kmeansLoop :: [(Centroid, [Color])] -> Double -> [(Centroid, [Color])]
kmeansLoop centroidColor limit = do
    let assignData = assignDataPoint (extractCentroidList centroidColor) (extractColorList centroidColor) (removeColor centroidColor)
    let newCentroid = computeNewCentroid assignData
    checkLimit newCentroid limit



-- !

printKMeansColor :: [Color] -> IO ()
printKMeansColor (first : remain) = print (first) >> printKMeansColor remain
printKMeansColor [] = return ()

printKMeans :: [(Centroid, [Color])] -> IO ()
printKMeans ((centroid, color) : remain) = print centroid >> printKMeansColor color >> printKMeans remain
printKMeans [] = return ()

-- startKMeans N L [Color]
startKMeans :: Int -> Double -> [Color] -> IO ()
startKMeans nbCluster limit color = do
    randomList <- createRandomList (nbCluster * 3)
    let centroid = initCentroid randomList
    let dataPoint = (assignDataPoint (centroid) color (initCentroidAndColor centroid))
    let newCentroid = computeNewCentroid dataPoint
    let res = kmeansLoop (fst newCentroid) limit
    printKMeans res
--    kmeansLoop newCentroid limit
