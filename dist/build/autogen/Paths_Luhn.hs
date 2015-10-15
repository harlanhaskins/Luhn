module Paths_Luhn (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/harlanhaskins/Library/Haskell/bin"
libdir     = "/Users/harlanhaskins/Library/Haskell/ghc-7.10.1-x86_64/lib/Luhn-0.1.0.0"
datadir    = "/Users/harlanhaskins/Library/Haskell/share/ghc-7.10.1-x86_64/Luhn-0.1.0.0"
libexecdir = "/Users/harlanhaskins/Library/Haskell/libexec"
sysconfdir = "/Users/harlanhaskins/Library/Haskell/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Luhn_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Luhn_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "Luhn_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Luhn_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Luhn_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
