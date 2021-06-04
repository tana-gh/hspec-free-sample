module HspecFreeSample.App where

import Control.Monad.Free
import HspecFreeSample.Config
import HspecFreeSample.AppCmd
import HspecFreeSample.AskCmd
import HspecFreeSample.PrintCmd

app :: Free (AppCmd Config String) ()
app = hoistPrintCmd . print' =<< hoistAskCmd (asks' (concat :: [String] -> String))
