import System.Environment
import System.Exit
import Text.Read
import Data.Maybe
import Luhn

printValid :: (Integer, Bool) -> IO ()
printValid (x, b)
    | b         = message "Valid: " x
    | otherwise = message "Invalid: " x
    where message s x = putStrLn $ s ++ (show x)

validities :: [Integer] -> [(Integer, Bool)]
validities = map validity
    where validity x = (x, isValidAccount x)

validAccounts :: [Integer] -> [Integer]
validAccounts = catMaybes . map validate

validate :: Integer -> Maybe Integer
validate x
    | isValidAccount x = Just x
    | otherwise = Nothing

parse :: [String] -> IO [Integer]
parse ["-h"] = usage >> exit
parse ["-v"] = version >> exit
parse [] = fmap (integerArguments . lines) getContents
parse ("-q":ns) = return $ (validAccounts . integerArguments) ns
parse ns = return $ integerArguments ns

integerArguments :: [String] -> [Integer]
integerArguments = catMaybes . maybes
    where maybes = map readMaybe

usage = putStrLn "Usage: luhn [-vh] [account ...]"
version = putStrLn "Haskell Luhn 0.1"
exit = exitWith ExitSuccess
die = exitWith (ExitFailure 1)

main :: IO ()
main = getArgs >>= parse >>= mapM_ printValid . validities
