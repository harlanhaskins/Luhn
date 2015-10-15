module Luhn where

import Data.Digits

{- A suite of tools to validate credit cards using
 - the luhn card validation algorithm
 - http://en.wikipedia.org/wiki/Luhn_algorithm
 -}

numbers = digits 10
isValidAccount x = (x `mod` 10) == checkDigit (x `quot` 10)
fullAccountNumber x = (x * 10) + checkDigit x
checkDigit = (`mod` 10) . (* 9) . sum . doubleOdd . numbers
doubleOdd = zipWith ($) $ cycle [sum . numbers . (* 2), id]
