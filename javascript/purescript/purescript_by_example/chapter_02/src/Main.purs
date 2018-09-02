module Main where

import Prelude
import Control.Monad.Eff (Eff())
import Control.Monad.Eff.Console
import Math (sqrt, pi)

main :: forall a. Eff( console :: CONSOLE | a ) Unit
main = do
  print_newline
  log "Hello Obi!!"
  print $ diagonal 3.0 4.0
  print $ circle_area 1.0
  print_newline

print_newline :: forall a. Eff( console :: CONSOLE | a ) Unit
print_newline = log ""

diagonal :: Number -> Number -> Number
diagonal w h = sqrt(w * w + h * h)

circle_area :: Number -> Number
circle_area r = 2.0 * pi * r * r
