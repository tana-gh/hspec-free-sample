{-# LANGUAGE DeriveFunctor #-}

module HspecFreeSample.AppCmd where

import Control.Monad.Free
import HspecFreeSample.AskCmd
import HspecFreeSample.PrintCmd

data AppCmd s a next
    = AskCmd'   (AskCmd s a next)
    | PrintCmd' (PrintCmd a next)
    deriving Functor

hoistAskCmd :: Free (AskCmd s t) a -> Free (AppCmd s t) a
hoistAskCmd = hoistFree AskCmd'

hoistPrintCmd :: Free (PrintCmd t) a -> Free (AppCmd s t) a
hoistPrintCmd = hoistFree PrintCmd'
