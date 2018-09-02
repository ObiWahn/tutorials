module FileSystem where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Console

import Data.Maybe
import Data.Array
import Data.Foldable

--import Node.Path
--import Data.Path.Pathy
import Data.Path
import FileOperations

main :: forall a. Eff( console :: CONSOLE | a ) Unit
main = do
    log $ "-- 4.16 (A Virtual Filesystem)"
    print $ root
    print $ ls root
    print "allfiles'"
    print $ allFiles' root
    print "allfiles_"
    print $ allFiles_ root
    
    log $ "-- 4.17 (Listing All Files)"
    log $ "ex 1"
    print $ onlyFiles root
    log $ "ex 2"
    print $ smallestFile root
    print $ greatestFile root
    log $ "ex 3"
    print $ whereIs "/home/user/todo.txt"
