module MainDefs where

import Prelude
import Data.Maybe
import Data.Foldable

--5.3
gcd :: Int -> Int -> Int
gcd n 0 = n
gcd 0 m = m
gcd n m = if n > m then gcd (n - m) m else gcd n (m - n)

--5.4
fromString :: String -> Boolean
fromString "true" = true
fromString _      = false

toString :: Boolean -> String
toString true  = "true"
toString false = "false"

--5.5
gcd' :: Int -> Int -> Int
gcd' n 0 = n
gcd' 0 n = n
gcd' n m | n > m     = gcd' (n - m) m
         | otherwise = gcd' n (m - n)

--ex1
fac :: Int -> Int
fac 0 = 1
fac n = n * fac(n-1)

fac' :: Int -> Int
fac' n = fac_ 1 n
    where
    fac_ :: Int -> Int -> Int
    fac_ acc 0 = acc
    fac_ acc n = fac_ (acc*n) (n-1)

--ex2
bion :: Int -> Int -> Int
bion n k | n > k     = (fac' n) / ((fac' k) * (fac' (n-k)))
         | otherwise = 1

bion' :: Int -> Int -> Int
bion' n k | k == 1    = n
          | n <= k    = 1
          | otherwise = (bion' (n-1) k) + (bion' (n-1) (k-1))

-- 5.8
type Address = { street :: String, city :: String }
type Person = { name :: String, address :: Address }
livesInLA :: Person -> Boolean
livesInLA { address: { city: "Los Angeles" } } = true
livesInLA _ = false

-- 5.9
sameCity :: Person -> Person -> Boolean
sameCity a b = a.address.city == b.address.city

fromSingleton :: forall a. a -> Array a -> a
fromSingleton _ [x]      = x
fromSingleton default _  = default


-- 5.11 (causes compiler warning)
redundantCase :: Boolean -> Boolean
redundantCase true = true
redundantCase true = false


--5.12 (Algebraic Data Types)

data Shape
  = Circle Point Number
  | Rectangle Point Number Number
  | Line Point Point
  | Text Point String
  | Clipped Picture

data Point = Point
  { x :: Number
  , y :: Number
  }

-- 5.13 (Using ADTs)
showPoint :: Point -> String
showPoint (Point {x = x, y = y}) =
    "(" ++ show x ++ ", " ++ show y ++ ")"

showShape :: Shape -> String
showShape (Circle  c r) =
    "C(" ++ showPoint c ++ ", " ++ show r ++ ")"
showShape (Rectangle c w h) =
    "(" ++ showPoint c ++ ", " ++ show h ++ ", " ++ show w ++ ")"
showShape (Line start end) =
    "L(" ++ showPoint start ++ ", " ++ showPoint end ++ ")"

instance showShape_real :: Show Shape where
    show = showShape

scaleShape :: Shape -> Shape
scaleShape (Circle  c r) = Circle c (r*2.0)
scaleShape (Rectangle c w h) = Rectangle c (w*2.0) (h*2.0)
scaleShape (Line start end) = Line start end

extractText :: Shape -> Maybe String
extractText (Text p s) = Just s
extractText _ = Nothing

-- 5.14 (NewTypes)
newtype Pixels = Pixels Number
newtype Meter  = Meter Number

-- 5.15 (A Library for Vector Graphics)
type Picture = Array Shape
showPicture :: Picture -> Array String
showPicture = map showShape

-- 5.16 (Computing Bounding Rectangles
-- form repo for book
data Bounds = Bounds
  { top    :: Number
  , left   :: Number
  , bottom :: Number
  , right  :: Number
  }

showBounds :: Bounds -> String
showBounds (Bounds b) =
  "Bounds [top: " ++ show b.top ++
  ", left: "      ++ show b.left ++
  ", bottom: "    ++ show b.bottom ++
  ", right: "     ++ show b.right ++
  "]"

shapeBounds :: Shape -> Bounds
shapeBounds (Circle (Point { x = x, y = y }) r) = Bounds
  { top:    y - r
  , left:   x - r
  , bottom: y + r
  , right:  x + r
  }
shapeBounds (Rectangle (Point { x = x, y = y }) w h) = Bounds
  { top:    y - h / 2.0
  , left:   x - w / 2.0
  , bottom: y + h / 2.0
  , right:  x + w / 2.0
  }
shapeBounds (Line (Point p1) (Point p2)) = Bounds
  { top:    Math.min p1.y p2.y
  , left:   Math.min p1.x p2.x
  , bottom: Math.max p1.y p2.y
  , right:  Math.max p1.x p2.x
  }
shapeBounds (Text (Point { x = x, y = y }) _) = Bounds
  { top:    y
  , left:   x
  , bottom: y
  , right:  x
  }
shapeBounds (Clipped pic) = bounds pic

(\/) :: Bounds -> Bounds -> Bounds
(\/) (Bounds b1) (Bounds b2) = Bounds
  { top:    Math.min b1.top    b2.top
  , left:   Math.min b1.left   b2.left
  , bottom: Math.max b1.bottom b2.bottom
  , right:  Math.max b1.right  b2.right
  }

(/\) :: Bounds -> Bounds -> Bounds
(/\) (Bounds b1) (Bounds b2) = Bounds
  { top:    Math.max b1.top    b2.top
  , left:   Math.max b1.left   b2.left
  , bottom: Math.min b1.bottom b2.bottom
  , right:  Math.min b1.right  b2.right
  }

emptyBounds :: Bounds
emptyBounds = Bounds
  { top:     Global.infinity
  , left:    Global.infinity
  , bottom: -Global.infinity
  , right:  -Global.infinity
  }

infiniteBounds :: Bounds
infiniteBounds = Bounds
  { top:    -Global.infinity
  , left:   -Global.infinity
  , bottom:  Global.infinity
  , right:   Global.infinity
  }

bounds :: Picture -> Bounds
bounds = foldl combine emptyBounds
  where
  combine :: Bounds -> Shape -> Bounds
  combine b shape = shapeBounds shape \/ b
-- form repo for book - end

area :: Shape -> Number
area (Circle _ r) = r * r * Math.pi
area (Rectangle _ w h) = w * h
area (Line _ _) = 0.0
area (Text _ _) = 0.0
