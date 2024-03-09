{-
-- EPITECH PROJECT, 2024
-- B-FUN-400-PAR-4-1-compressor-thibaud.cathala
-- File description:
-- compression
-}

module KMeans.Compression (startKMeans) where
import DataStruct (Pixel(..), Centroid(..))
import KMeans.ComputeNewCentroid (computeNewCentroid)
import KMeans.EuclidianDistance (euclidianDistanceCent)
import KMeans.ExportInPng (exportInPng)
import KMeans.GetFirstNColor (getFirstNColor)
import KMeans.PrintKMeans (printKMeans)
import KMeans.ReassignColor (reassignColor)
import System.Exit
import System.Random (randomRIO)

createRandomList :: Int -> IO [Int]
createRandomList 0 = return []
createRandomList nbCentroid = do
    randomNb <- randomRIO (0, 255)
    remain <- createRandomList (nbCentroid - 1)
    return (randomNb : remain)
-- ! ----------------------------------

getMaxDistance :: ([Centroid], [Centroid]) -> Double -> Double
getMaxDistance ((firstPrev : remainPrev), (first : remain)) maxD
    | distance > maxD = getMaxDistance (remainPrev, remain) distance
    | otherwise = getMaxDistance (remainPrev, remain) maxD
    where
        distance = euclidianDistanceCent firstPrev first
getMaxDistance ([], []) maxD = maxD
getMaxDistance (_, _) maxD = maxD

checkLimit :: [Centroid] -> ([Centroid], [Pixel]) -> Double -> ([Centroid], [Pixel])
checkLimit prevCentroid centroid limit
    | (getMaxDistance (prevCentroid, (fst centroid)) 0) >= limit = kmeansLoop centroid limit
    | otherwise = centroid

kmeansLoopHelper :: ([Centroid], [Pixel]) -> Double -> ([Centroid], [Pixel])
kmeansLoopHelper (prevCentroid, newPixel) limit
    = checkLimit prevCentroid ((computeNewCentroid (prevCentroid, newPixel)), newPixel) limit

kmeansLoop :: ([Centroid], [Pixel]) -> Double -> ([Centroid], [Pixel])
kmeansLoop (prevCentroid, pixel) limit =
    kmeansLoopHelper (prevCentroid, (reassignColor (prevCentroid, pixel))) limit

-- startKMeans N L IsGraphical [Pixel]
startKMeans :: Maybe Int -> Maybe Double -> (Bool, Maybe String) -> [Pixel] -> IO ()
startKMeans (Just nbCluster) (Just limit) (False, _) color = do
    randomList <- createRandomList (nbCluster * 3)
    printKMeans (kmeansLoop ((getFirstNColor nbCluster color [] randomList), color) limit)
startKMeans (Just nbCluster) (Just limit) (True, Just filePath) color = do
    randomList <- createRandomList (nbCluster * 3)
    exportInPng (kmeansLoop ((getFirstNColor nbCluster color [] randomList), color) limit) filePath
startKMeans _ _ _ _ = exitWith (ExitFailure 84)
