module Main where

import Prelude (Unit, ($), bind, id, const)
import Data.Either (either)

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Aff (launchAff, liftEff')
--import Debug.Trace (trace)

--import Data.JSON as JS
import Network.HTTP.Affjax as AJ
import DOM (DOM)
import DOM.File.Types (Blob)

import Util.DOM

result :: forall e. AJ.Affjax e Blob
result = AJ.get "http://chart.googleapis.com/chart?chs=300x300&cht=s&chxt=x,y&chd=t:12,87,75,41,23,96,68,71,34,9|98,60,27,34,56,79,58,74,18,76|84,23,69,81,47,94,60,93,64,54&chco=FF0000|0000FF&chdl=Cats|Dogs"

main :: forall eff. Eff ( err :: EXCEPTION, ajax :: AJ.AJAX, dom :: DOM | eff ) Unit
main = launchAff $ do
          r <- result
          urlE <- liftEff' $ blob2url r.response
          liftEff' $ tryWithNode "#chart" $ setSrc $ either (const "bad") id urlE
