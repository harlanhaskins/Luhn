module Luhn where

import Data.Digits

{- A suite of tools to validate credit cards using
 - the luhn card validation algorithm
 - http://en.wikipedia.org/wiki/Luhn_algorithm
 -}

-- Checks if an account number is valid.
isValidAccount :: Integer -> Bool
isValidAccount x = (x `mod` 10) == checkDigit (x `quot` 10)

-- Takes an incomplete account number and appends
-- its check digit
fullAccountNumber :: Integer -> Integer
fullAccountNumber x = (x * 10) + (checkDigit x)

-- Shorthand for digits
numbers :: Integer -> [Integer]
numbers = digits 10

-- Takes a 15-digit account number and computes
-- a check digit.
checkDigit :: Integer -> Integer
checkDigit = moduloSum . sum . doubleOdd . numbers

-- Takes a number, multiplies it by 9,
-- and modulos that by 10.
moduloSum :: Integer -> Integer
moduloSum = (`mod` 10) . (* 9)

-- Doubles every odd index in a list
doubleOdd :: [Integer] -> [Integer]
doubleOdd = zipWith ($) $ cycle [doubleAndAdd, id]

-- Doubles a number and adds its digits together.
doubleAndAdd :: Integer -> Integer
doubleAndAdd = sum . numbers . (* 2)
