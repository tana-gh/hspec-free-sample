module Main where

import Control.Monad.Reader
import HspecFreeSample.App
import HspecFreeSample.AppRunner

main :: IO ()
main = (`runReaderT` ["Hello, ", "world!"]) $ runApp app
