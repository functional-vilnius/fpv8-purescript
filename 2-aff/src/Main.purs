module Main where

import Prelude (($), pure, bind, id, const, unit, show)
import Data.Either
import Control.Monad.Eff.Class
import Control.Monad.Aff (launchAff, liftEff')
--import Data.JSON as JS
import Network.HTTP.Affjax as AJ
import DOM.File.Types (Blob())
import Util.DOM

import Debug.Trace (trace)

ajget :: forall e. AJ.Affjax e Blob
ajget = AJ.get "http://chart.googleapis.com/chart?chs=300x300&cht=s&chxt=x,y&chd=t:12,87,75,41,23,96,68,71,34,9|98,60,27,34,56,79,58,74,18,76|84,23,69,81,47,94,60,93,64,54&chco=FF0000|0000FF&chdl=Cats|Dogs"


main = do
         launchAff $ do
          r <- ajget
          urlE <- liftEff' $ blob2url r.response
          liftEff' $ tryWithNode "#chart" $ setSrc $ either (const "bad") id urlE
