module HspecFreeSample.AppRunner where

import Control.Monad.Free
import Control.Monad.Reader
import HspecFreeSample.AppCmd
import HspecFreeSample.AskCmd
import HspecFreeSample.PrintCmd

runApp :: (MonadReader s m, MonadIO m, Show t) => Free (AppCmd s t) a -> m a
runApp = iterM run
    where
    run :: (MonadReader s m, MonadIO m, Show t) => AppCmd s t (m a) -> m a
    run (AskCmd'   cmd) = runAskCmd   cmd
    run (PrintCmd' cmd) = runPrintCmd cmd

    runAskCmd :: MonadReader s m => AskCmd s t (m a) -> m a
    runAskCmd (Asks' f next) = asks f >>= next

    runPrintCmd :: (MonadIO m, Show t) => PrintCmd t (m a) -> m a
    runPrintCmd (Print' t next) = liftIO (print t) >> next
