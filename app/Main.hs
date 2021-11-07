{-# LANGUAGE NoImplicitPrelude #-}
module Main where

import Cabalinfo.CustomPrelude
import Cabalinfo (cabalinfoMain)

main :: IO ()
main = do
  cabalinfoMain
