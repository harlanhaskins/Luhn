import Criterion.Main
import System.IO.Unsafe
import Luhn
import Data.Maybe
import Text.Read

integerArguments :: [String] -> [Integer]
integerArguments = catMaybes . maybes
    where maybes = map readMaybe

check = fmap (all . isValidAccount)

cardNumbers = fmap (integerArguments . lines) cards

cards = readFile "cards.txt"

main = defaultMain [ bgroup "luhn" [ bench "1,000,000,000" $ whnf check cardNumbers ] ]
