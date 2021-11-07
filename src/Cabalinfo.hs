module Cabalinfo (
  module Cabalinfo
 ) where

import Cabalinfo.Helpers.SignalHandlers

cabalinfoMain :: IO ()
cabalinfoMain = do
    installSignalHandlers
    putStrLn "Hello from cabalinfo"
