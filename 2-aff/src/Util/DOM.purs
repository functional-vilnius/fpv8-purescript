module Util.DOM ( tryWithNode, setText, setSrc, blob2url ) where

import Prelude (Unit, unit, ($), (++), void, bind, pure)

import Data.Maybe (Maybe(..))
import Data.Function (Fn3, runFn3)
import Control.Monad.Eff (Eff)
import DOM (DOM)
import DOM.File.Types (Blob())
import DOM.Node.Types (Node())
import Debug.Trace (trace)

tryWithNode :: forall eff a. String -> (Node -> Eff ( dom :: DOM | eff ) a ) -> Eff ( dom :: DOM | eff ) Unit
tryWithNode divName fun = do
  maybeDiv <- querySelector divName
  case maybeDiv of
    Just div -> void $ fun div
    Nothing -> pure $ trace ("Cannot find node " ++ divName) (\_ -> unit)

foreign import querySelectorImpl :: forall eff r. Fn3 r (Node -> r) String (Eff (dom :: DOM | eff) r)

querySelector :: forall eff. String -> Eff (dom :: DOM | eff) (Maybe Node)
querySelector s = runFn3 querySelectorImpl Nothing Just s

foreign import setText :: forall eff. String -> Node -> Eff (dom :: DOM | eff) Node

foreign import setSrc :: forall eff. String -> Node -> Eff (dom :: DOM | eff) Node

foreign import blob2url :: forall eff. Blob -> Eff (dom :: DOM | eff) String
