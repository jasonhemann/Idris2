import Data.List
import Data.String
import System.File

path : String
path = "build/exec/fold_app/fold.ss"

mainLine : String -> Bool
mainLine str =
  ("(define Main-main" `isPrefixOf` str) &&
  not ("Main-unsafeMkSingleton" `isInfixOf` str)

main : IO ()
main = do
  Right str <- readFile path
    | Left err => putStrLn "Error when reading \{path}"
  case any mainLine (lines str) of
    True  => putStrLn "Constant expression correctly folded"
    False => putStrLn "Failed to fold constant expression"