module Main where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Console
import MainDefs

main :: forall a. Eff( console :: CONSOLE | a ) Unit
main = do
  log "5.3"
  log "gcd 5 50"
  print $ gcd 5 50

  log "5.5"
  log "ex1"
  print $ fac  8
  print $ fac' 8

  log "ex2"
  print $ bion   5 2
  print $ bion'  5 2

  log "5.7"
  let showPerson1 :: { first :: String, last :: String } -> String
      showPerson1 { first: x, last: y } = y ++ ", " ++ x
  let showPerson2 :: forall r. { first :: String, last :: String | r } -> String
      showPerson2 { first: x, last: y } = y ++ ", " ++ x
  print $ showPerson2 { first: "Phil", last: "Freeman" }
  print $ showPerson2 { first: "Phil", last: "Freeman", location: "Los Angeles" }


  log "5.8"
  print $ livesInLA { name: "Carl" , address: { street: "MyStreet", city: "NY" }}
  print $ livesInLA { name: "n" , address: { street: "s", city: "Los Angeles" }}

  log "5.9"
  let carl = { name: "Carl" , address: { street: "MyStreet", city: "Los Angeles" }}
      obi  = { name: "Obi"  , address: { street: "EifelStr", city: "Aachen" }}
  -- ex1
  print $ sameCity carl obi
  -- ex2
  let livesInLA2 = sameCity { name: "", address: { street:"" , city: "Los Angeles"}}
  print $ livesInLA2 carl
  -- ex3
  print $ fromSingleton "default" ["krasser","unfug"]
  print $ fromSingleton "default" ["hello!"]

  log "5.13"
  -- this is tricky just ONE let
  -- one let: let {a= , b= } in ...
  -- two let: let {a= } in let {b= } in ...
  let exampleLine :: Shape
      exampleLine = Line p1 p2
        where
        p1 :: Point
        p1 =  Point { x: 0.0, y: 0.0 }
        p2 :: Point
        p2 =  Point { x: 100.0, y: 50.0 }

  -- ex1
  let centerp :: Point
      centerp =  Point { x: 0.0, y: 0.0 }
  print $ showShape $ Circle centerp 10.0
  print $ showShape $ Circle (Point {x: 0.0,y: 0.0}) 10.0
  -- ex2
  print $ showShape $ scaleShape $ Circle (Point {x: 0.0,y: 0.0}) 10.0

  log "5.15"
  print $ showPicture $ [ Line (Point { x: 0.0, y: 0.0} )
                               (Point { x: 1.0, y: 1.0} )
                        ]

  log "5.16 Computing Bounding Rectangles"
  print $ showBounds $ shapeBounds $  Circle centerp 10.0
  print $ showBounds $ shapeBounds $  Clipped [ Circle centerp 10.0 ]
  -- 6.13 - ex1
  log $ showShape $ scaleShape $ Circle (Point {x: 0.0,y: 0.0}) 10.0
  print $ scaleShape $ Circle (Point {x: 0.0,y: 0.0}) 10.0
