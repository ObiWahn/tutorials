module FileOperations where

import Prelude

import Data.Path
import Data.Array
import Data.Maybe
import Data.Foldable
import Control.MonadPlus
import Control.Apply

allFiles :: Path -> Array Path
allFiles root = root : concatMap allFiles (ls root)

allFiles' :: Path -> Array Path
allFiles' file = file : do
  child <- ls file
  allFiles' child

allFiles_ :: Path -> Array Path
allFiles_ d = d : ( ls d >>= allFiles_ )

-- 4.17
-- ex 1
--onlyFilesOrDirs :: Path -> Array Path
--onlyFiles = filter (\x -> not $ isDirectory x) <<< allFiles_ 
--onlyFiles d = (if isDirectory d then id else (d:)) ls d >>= onlyFiles
onlyFilesOrDirs :: (Boolean -> Boolean) -> Path -> Array Path
onlyFilesOrDirs p d = if (p $ isDirectory d)
                then detail d
                else d : detail d
              where
                detail x = ls x >>= (onlyFilesOrDirs p)

onlyFiles :: Path -> Array Path
onlyFiles = onlyFilesOrDirs id

onlyDirs :: Path -> Array Path
onlyDirs = onlyFilesOrDirs not

--ex 2
sizeComp :: (Maybe Int -> Maybe Int -> Boolean) -> Path -> Maybe Path
sizeComp predicate dir =
    foldl compareWith Nothing (onlyFiles dir)
        where
        compareWith (Just l) r = if (predicate (size l) (size r))
                                 then Just l
                                 else Just r
        compareWith Nothing r  = Just r

smallestFile :: Path -> Maybe Path
smallestFile dir = sizeComp (<) dir

greatestFile :: Path -> Maybe Path
greatestFile dir = sizeComp (>) dir

--ex 3
whereIs :: String -> Maybe Path
whereIs filename_ = head $ ( onlyDirs root
    >>= \ dir -> ls dir
    >>= \ file -> guard (filename file == filename_)
    *>  return(dir))  -- get rid of the ugly lambda
