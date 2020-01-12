module HspecFreeSample.App where

import Control.Monad.Free
import HspecFreeSample.AppCmd
import HspecFreeSample.AskCmd
import HspecFreeSample.PrintCmd

app :: Free (AppCmd [String] String) ()
app = do
    ma <- hoistAskCmd $ asks' (concat :: [String] -> String)
    case ma of
        Just a  -> hoistPrintCmd $ print' a
        Nothing -> return ()
