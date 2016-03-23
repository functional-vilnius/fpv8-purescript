module Main where

import Prelude (Unit, negate, ($), bind)
import Data.Maybe (Maybe(..))
import Control.Monad.Eff (Eff)
import DOM (DOM)
import DyGraphs (DyData(Array2D, CSV), defaultDyOpts, newDyGraph, RunDyGraph)
import Util.DOM (tryWithNode, setText)

plotData :: DyData
plotData = CSV "0,1,10\n1,2,20\n2,3,30\n3,4,40"

plotData2 :: DyData
plotData2 = Array2D $ [ [0.0,  0.0 ,  0.0 ,  0.0]
                      , [0.1,  0.1 , -0.2 ,  0.3]
                      , [0.2, -0.1 ,  0.2 ,  0.3]
                      , [0.3,  0.15, -0.25, -0.3]
                      ]

main :: forall eff. Eff ( dom :: DOM, runDyGraph :: RunDyGraph | eff ) Unit
main = do
  tryWithNode "#graph1" $ \d -> newDyGraph d plotData defaultDyOpts
  tryWithNode "#graph2" $ \d ->
    newDyGraph d plotData2 defaultDyOpts
      { stepPlot = Just true
      , clickCallback = Just $ \e x pts -> do
          tryWithNode "#msg" $ setText "Canvas clicked!"
      , highlightCallback = Just $ \e x pts r s -> do
          tryWithNode "#msg" $ setText "Point highlighted!"
      , title = Just $ "Chart with non-default options"
      , xlabel = Just $ "X label here"
      , ylabel = Just $ "Y label here!"
      }

