{-# LANGUAGE DeriveFunctor              #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralisedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE RankNTypes                 #-}

module HspecFreeSample.Spec.Mock where

import Control.Monad.Free
import Control.Monad.State
import HspecFreeSample.AppCmd
import HspecFreeSample.AskCmd
import HspecFreeSample.PrintCmd

newtype Mock m a = Mock
    { runMock :: StateT MockState m a
    } deriving
    ( Functor
    , Applicative
    , Monad
    , MonadTrans
    , MonadState MockState
    )

data MockState = MockState
    { asksState  :: [String]
    , printState :: [String]
    }

initialMockState :: MockState
initialMockState = MockState [] []

asksCalled :: String
asksCalled = "asks called"

runApp :: Free (AppCmd [String] String) a -> Mock IO a
runApp = iterM run
    where
    run :: AppCmd [String] String (Mock IO a) -> Mock IO a
    run (AskCmd'   cmd) = runAskCmd   cmd
    run (PrintCmd' cmd) = runPrintCmd cmd

    runAskCmd :: AskCmd [String] String (Mock IO a) -> Mock IO a
    runAskCmd (Asks' _ next) = do
        modify $ \s -> s { asksState = asksCalled : asksState s }
        next $ Just asksCalled

    runPrintCmd :: PrintCmd String (Mock IO a) -> Mock IO a
    runPrintCmd (Print' t next) = do
        modify $ \s -> s { printState = t : printState s }
        next
