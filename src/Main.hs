import System.Environment
import System.Exit
import Text.Read
import Data.Maybe
import Luhn

printValid (x, b) = putStrLn $ (if b then "Valid: " else "Invalid: ") ++ (show x)

validities = map (\x -> (x, isValidAccount x))

validAccounts = filter isValidAccount

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
exit = exitSuccess
die = exitWith (ExitFailure 1)

main :: IO ()
main = getArgs >>= parse >>= mapM_ printValid . validities
