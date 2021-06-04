{-# LANGUAGE GeneralisedNewtypeDeriving #-}

module HspecFreeSample.Spec.Mock where

import Control.Monad.Free
import Control.Monad.State
import HspecFreeSample.Config
import HspecFreeSample.AppCmd
import HspecFreeSample.AskCmd
import HspecFreeSample.PrintCmd

newtype Mock s m a = Mock
    { runMock :: StateT s m a
    } deriving
    ( Functor
    , Applicative
    , Monad
    , MonadTrans
    , MonadState s
    )

data MockState = MockState
    { asksState  :: [String]
    , printState :: [String]
    }

initialMockState :: MockState
initialMockState = MockState [] []

config :: Config
config = ["config1", "config2"]

asksCalled :: String
asksCalled = "asks called"

runApp :: Monad m => Free (AppCmd Config String) a -> Mock MockState m a
runApp = iterM run
    where
    run :: Monad m => AppCmd [String] String (Mock MockState m a) -> Mock MockState m a
    run (AskCmd'   cmd) = runAskCmd   cmd
    run (PrintCmd' cmd) = runPrintCmd cmd

    runAskCmd :: Monad m => AskCmd [String] String (Mock MockState m a) -> Mock MockState m a
    runAskCmd (Asks' f next) = do
        modify $ \s -> s { asksState = asksCalled : asksState s }
        next . show $ f config

    runPrintCmd :: Monad m => PrintCmd String (Mock MockState m a) -> Mock MockState m a
    runPrintCmd (Print' t next) = do
        modify $ \s -> s { printState = t : printState s }
        next
