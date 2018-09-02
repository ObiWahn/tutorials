module Main where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Console


import Data.Maybe
import Data.Array
import Data.Foldable


-- 4.4
--import Data.Array.Unsafe (tail)
--length :: forall a. Array a -> Int
--length arr =
--    if null arr
--    then 0
--    else 1 + length (tail arr)


mylength :: forall a. Array a -> Int
mylength arr =
    case tail arr of
        Nothing -> 0
        Just ta -> 1+mylength(ta)

-- 4.4 (recursion)
is_even :: Int -> Boolean
is_even 0 = false
is_even 1 = false
is_even 2 = true
is_even x = is_even (x-2)

even_in_array :: Array Int -> Int
even_in_array = foldl (+) 0 <<< map (\n ->(\x -> if x then 1 else 0) $ is_even n)

-- 4.5 (maps)
str_array_int :: Array Int -> String
str_array_int arr = foldl (\x y -> x ++ " " ++ y) "" $ map show arr

-- 4.10 (do notation)
factors1 :: Int -> Array (Array Int)
factors1 n = filter (\xs -> product xs == n) $ do
    i <- 1 .. n
    j <- i .. n
    --return [1, 2] :: Array (Array Int) -- we have to provide the type?
    return [i, j]

factors2 :: Int -> Array (Array Int)
factors2 n = filter (\xs -> product xs == n) $ do
    i <- 1 .. n
    j <- i .. n
    [[i, j]]

-- 4.11 (guards)
import Control.MonadPlus (guard)
factors3 :: Int -> Array (Array Int)
factors3 n = filter (\xs -> product xs == n) $ do
    i <- 1 .. n
    j <- i .. n
    -- > :type guard
    -- forall m. (MonadPlus m) => Boolean -> m Unit
    guard $ i * j == n 
    [[i, j]]

-- 4.11 (guards) - exercise
isPrime :: Int -> Boolean
isPrime n = case ta of
                 Just ([]) -> true
                 _         -> false
            where
                ta = tail $ factors3 n


import Data.Tuple
crossAA :: forall a b. Array a -> Array b -> Array (Tuple a b)
crossAA first second = do
    i <- first
    j <- second
    [Tuple i j]

(%) :: Int -> Int -> Int
(%) x n | x >= n    = mod (x-n) n
        | otherwise = x
infix 5 %

-- stolen form  https://github.com/beckyconning/purescript-by-example
actualFactors :: Int -> Array Int
actualFactors n = do
    i <- 1 .. n
    guard $ n `mod` i == 0
    return i

factorizations_detail :: Int -> Array (Array Int)
factorizations_detail n = [n] : (actualFactors n
    >>= \ x  -> guard (x > 1 && x < n)
    >>= \ _  -> factorizations_detail (n / x)
    >>= \ ys -> return (x : ys))

-- i do not see how do notation makes this easier to understand
factorizations_detail n = [n] : (do
    x <- actualFactors n
    guard (x > 1 && x < n)
    ys <- factorizations_detail (n / x)
    return (x : ys))


actualFactors2 :: Int -> Array Int
actualFactors2 n = do
    i <- 1 .. n
    guard (n `mod` i == 0)
    guard (i > 1 && i < n)
    return i

--rewrite the function as concatMap
factorizations_detail2 :: Int -> Array (Array Int)
factorizations_detail2 1 = [[1]]
factorizations_detail2 n = [n] :
    (concatMap (\ x -> concatMap (\ ys -> [x:ys])
                                 (factorizations_detail2 (n/x)))
               (actualFactors2 n))
-- becky - end

factorizations :: Int -> Array (Array Int)
factorizations n = nubBy (\ x y -> x == y) $ map sort $ factorizations_detail n

factorizations2 :: Int -> Array (Array Int)
factorizations2 n = nubBy (\ x y -> x == y) $ map sort $ factorizations_detail2 n

-- 4.13 (tail recursion) and 4.14 (accumulators)
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib(n-1) + fib(n-2)

-- with tail recursion
fibt :: Int -> Int
fibt n = fibtail 1 1 n
    where
    fibtail :: Int -> Int -> Int -> Int
    fibtail acc _ 2 = acc
    fibtail x   y n = fibtail (x+y) (x) (n-1)

-- 4.15

trueToOne :: Boolean -> Int
trueToOne true  = 1
trueToOne false = 0

--count :: forall a. (a -> Boolean) -> Array a -> Int
--count _ [] = 0
--count p xs = if p (head xs)
--             then count p (tail xs) + 1
--             else count p (tail xs)

--ex 3 - something like this (untested)
--count :: forall a. (a -> Boolean) -> Array a -> Int
--count p xs = count_imp 0 p xs
--  where
--  count acc _ []  = acc
--  count acc p xs  = count (acc + (trueToOne (head xxs)))
--                          p
--                          (tail xs)

--ex 4
count :: forall a. (a -> Boolean) -> Array a -> Int
count p xxs = foldl (+) 0
            $ map trueToOne
            $ map p xxs


print_array_int :: forall a. Array Int -> Eff ( console::CONSOLE | a) Unit
print_array_int = log <<< str_array_int

main :: forall a. Eff( console :: CONSOLE | a ) Unit
main = do
    log $ "-- 4.4"
    log $ show $ mylength [1,2,3,4,5,6]
    log $ show $ is_even 12
    log $ show $ is_even 13
    log $ show $ [1,2,3,4,5]
    log $ show $ even_in_array [1,2,3,4,5]
    log $ "-- 4.5 (maps) -- 4.6 (infix)"
    log $ foldl (\x y -> x ++ " " ++ y) "" $ show <$> ( 1 .. 5 )
    log $ str_array_int (1 .. 10)

    log $ "-- 4.7 (filtering arrays)"
    print_array_int $ filter (\n -> n `mod` 3 == 0 ) (1 .. 10)
    print $ filter (\n -> n `mod` 3 == 0 ) (1 .. 10)

    log $ "-- 4.8 (flattening arrays)"
    print $ map (\n -> [n, n * n]) (1 .. 5)
    print $ concatMap (\n -> [n, n * n]) (1 .. 5)

    log $ "-- 4.9 (array comprehensions)"
    print $ (\n -> concatMap (\_ -> 1..n) (1..n)) 3
    print $ (\n ->
                concatMap (\i ->
                    map (\j -> [i,j]) (1..n)
                ) (1..n)
            ) 3
    let pairs = (\ n -> concatMap (\ i -> map (\ j -> [i,j])  -- lisp style formatting (thanks to zudov)
                                              (i..n))
                                  (1..n))
    print $ pairs 3
    let factors n = filter (\pair -> product pair == n) $ pairs n
    print $ factors 10

    log $ "-- 4.10 (do notation)"
    print $ factors1 10
    print $ factors2 10

    log $ "-- 4.11 (guards)"
    print $ factors3 10
    log $ "-- 4.11 (guards) - exercise"
    print $ isPrime 7
    print $ factors 100
    log "cross product of [1,2,3] ['a','b','c']:"
    print $ crossAA [1,2,3] ['a','b','c']
    log "10 % 8:"
    print $ 10 % 8
    log "factorizations of 100 (normal):"
    print $ factorizations  100
    log "factorizations of 100 (concatMap):"
    print $ factorizations2 100

    log "-- 4.12 (folding)"
    -- foldl :: forall a b f. (Foldable f) => (b -> a -> b) -> b -> f a -> b
    log $ foldl (\acc n -> acc ++ show n) "" [1,2,3,4,5]
    -- foldr :: forall a b f. (Foldable f) => (a -> b -> b) -> b -> f a -> b
    log $ foldr (\n acc -> acc ++ show n) "" [1,2,3,4,5]
    print $ foldl (-) 0 [1,2,3]
    print $ foldl (\ a b -> a - b ) 0 [1,2,3]

    print $ foldr (-) 0 [1,2,3]
    print $ foldr (\ a b -> a - b ) 0 [1,2,3]
    print $ foldr (\ b a -> a - b ) 0 [1,2,3] -- behaves like foldl
    print $ (1-(2-(3-0)))

    log "-- 4.13 (tail recursion) and 4.14 (accumulators)"
    print $ fib 8
    print $ fibt 8

    log "-- 4.15 (prefer folds)"
    let reverse :: forall a. Array a -> Array a
        reverse =  foldr (\x xs -> xs ++ [x]) []
    print $ reverse [1,2,3]
    -- ex1
    print $ foldl (&&) true [true,true,true]
    print $ foldl (&&) true [true,false,true]
    -- ex2
    print $ foldl (==) false [false,true,true,true]
    print $ foldl (==) false [false,true,true,false,true,false,true,true]
    print $ ((((false == false) == true) == false) == false)
    -- ex3 - ex4
    print $ count (\ x -> x == 7) [7,1,2,3,7]
