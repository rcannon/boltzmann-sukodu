{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_hmatrix (
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
version = Version [0,20,2] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/cannon/.cabal/store/ghc-8.10.5/hmtrx-0.20.2-eb499a2e/bin"
libdir     = "/Users/cannon/.cabal/store/ghc-8.10.5/hmtrx-0.20.2-eb499a2e/lib"
dynlibdir  = "/Users/cannon/.cabal/store/ghc-8.10.5/lib"
datadir    = "/Users/cannon/.cabal/store/ghc-8.10.5/hmtrx-0.20.2-eb499a2e/share"
libexecdir = "/Users/cannon/.cabal/store/ghc-8.10.5/hmtrx-0.20.2-eb499a2e/libexec"
sysconfdir = "/Users/cannon/.cabal/store/ghc-8.10.5/hmtrx-0.20.2-eb499a2e/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hmatrix_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hmatrix_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "hmatrix_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "hmatrix_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hmatrix_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hmatrix_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
