module Main where

import Prelude
import Data.Tuple
import Data.Tuple.Nested
import Data.Either
import Data.Monoid
import Data.Foldable

import Control.Monad.Eff
import Control.Monad.Eff.Console
import MainDefs

main :: forall a. Eff( console :: CONSOLE | a ) Unit
main = do
  log "6.3 (Show Me)"
  log $ show $ Tuple 1 "foo"
  print $ tuple3 1 "foo" true
  --log $ show $ Left 10
  log $ show (Left 10 :: Either Int String)

  log $ "6.4 (Common Type Classes)"
  log $ foldl append mempty ["Hello", " ", "World"]
  print $ foldl append mempty [[1, 2, 3], [4, 5], [6]]
  -- https://github.com/paf31/purescript-book-sources/blob/master/chapter6.md#foldable continue here
