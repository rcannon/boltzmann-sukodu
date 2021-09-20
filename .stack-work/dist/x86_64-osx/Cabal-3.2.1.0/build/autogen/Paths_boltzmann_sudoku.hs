{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_boltzmann_sudoku (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/cannon/Learning/Haskell/boltzmann_sudoku/boltzmann-sudoku/.stack-work/install/x86_64-osx/cf3c99b70ba0a76264261918d0740669b74122eebf4edbfed150cadcd12530d6/8.10.7/bin"
libdir     = "/Users/cannon/Learning/Haskell/boltzmann_sudoku/boltzmann-sudoku/.stack-work/install/x86_64-osx/cf3c99b70ba0a76264261918d0740669b74122eebf4edbfed150cadcd12530d6/8.10.7/lib/x86_64-osx-ghc-8.10.7/boltzmann-sudoku-0.1.0.0-AWgG2et7pjjBkGiJWvjq3S"
dynlibdir  = "/Users/cannon/Learning/Haskell/boltzmann_sudoku/boltzmann-sudoku/.stack-work/install/x86_64-osx/cf3c99b70ba0a76264261918d0740669b74122eebf4edbfed150cadcd12530d6/8.10.7/lib/x86_64-osx-ghc-8.10.7"
datadir    = "/Users/cannon/Learning/Haskell/boltzmann_sudoku/boltzmann-sudoku/.stack-work/install/x86_64-osx/cf3c99b70ba0a76264261918d0740669b74122eebf4edbfed150cadcd12530d6/8.10.7/share/x86_64-osx-ghc-8.10.7/boltzmann-sudoku-0.1.0.0"
libexecdir = "/Users/cannon/Learning/Haskell/boltzmann_sudoku/boltzmann-sudoku/.stack-work/install/x86_64-osx/cf3c99b70ba0a76264261918d0740669b74122eebf4edbfed150cadcd12530d6/8.10.7/libexec/x86_64-osx-ghc-8.10.7/boltzmann-sudoku-0.1.0.0"
sysconfdir = "/Users/cannon/Learning/Haskell/boltzmann_sudoku/boltzmann-sudoku/.stack-work/install/x86_64-osx/cf3c99b70ba0a76264261918d0740669b74122eebf4edbfed150cadcd12530d6/8.10.7/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "boltzmann_sudoku_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "boltzmann_sudoku_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "boltzmann_sudoku_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "boltzmann_sudoku_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "boltzmann_sudoku_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "boltzmann_sudoku_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
