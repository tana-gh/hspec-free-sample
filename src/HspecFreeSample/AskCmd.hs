{-# LANGUAGE DeriveFunctor    #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TemplateHaskell  #-}

module HspecFreeSample.AskCmd where

import Control.Monad.Free.TH
import Control.Monad.Trans.Free

data AskCmd s t next
    = Asks' (s -> t) (Maybe t -> next)
    deriving Functor

makeFree ''AskCmd
