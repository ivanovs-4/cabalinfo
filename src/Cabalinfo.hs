module Cabalinfo (
  module Cabalinfo
 ) where

import Cabal.Project qualified as CP
import Cabalinfo.Helpers.SignalHandlers
import Control.Lens
import Control.Monad
import Data.Generics.Labels ()
import Data.Generics.Product.Fields
import Distribution.Types.PackageName qualified as DTP
import Options.Applicative
import System.Directory qualified as SD
import System.FilePath

cabalinfoMain :: IO ()
cabalinfoMain = do
    installSignalHandlers
    join $ customExecParser (prefs showHelpOnError) $ info (opts <**> helper)
        ( fullDesc
       <> progDesc "Program to show some info about cabal package or project"
       )
  where
    opts :: Parser (IO ())
    opts = hsubparser $ mempty
      -- <> command "get-name" (info (pure getName) fullDesc)
      <> command "package-list" (info (packageList <$> packageListOpsParser) $ fullDesc
              <> header "List packages of cabal project"
            )

-- $> devCI
devCI :: IO ()
devCI = do
    -- packageList (PackageListOps ".")
    pure ()

getName :: IO ()
getName = do
    pure ()

packageListOpsParser :: Parser PackageListOps
packageListOpsParser = do
  pathToProject <- strArgument
    (  metavar "PATH_TO_CABAL_PROJECT_DIR"
    <> help  "Path to directory with cabal.project file"
    <> showDefault
    )
  return PackageListOps{..}

data PackageListOps
  = PackageListOps
    { pathToProject :: FilePath
    }

packageList :: PackageListOps -> IO ()
packageList PackageListOps {..} = do
    p <- SD.withCurrentDirectory pathToProject $
        CP.readProject "cabal.project"
    mapM_ putStrLn $
        p ^.. #prjPackages . traverse . _2
            . #packageDescription . #package . #pkgName
          & fmap DTP.unPackageName
