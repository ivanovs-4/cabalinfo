{-# language NoImplicitPrelude #-}

module Prelude
  ( module X
  , module Prelude
  ) where

import BasePrelude as X

import Control.Arrow as X (
    (>>>)
  , (<<<)
  )

import Control.Applicative as X
import Control.Monad as X
import Data.Function as X
import Data.Functor as X

import GHC.Show as X

import Safe as X (
    headMay
  , initMay
  , lastMay
  , tailMay
  )