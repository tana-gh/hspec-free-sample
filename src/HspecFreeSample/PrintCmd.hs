{-# LANGUAGE DeriveFunctor    #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TemplateHaskell  #-}

module HspecFreeSample.PrintCmd where

import Control.Monad.Free
import Control.Monad.Free.TH

data PrintCmd t next
    = Print' t next
    deriving Functor

makeFree ''PrintCmd
