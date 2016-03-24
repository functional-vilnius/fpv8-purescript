module Main where

import Prelude (Unit, negate, ($), (#), (<#>), bind, (>>>))
import Data.Int (toNumber)
import Data.Tuple
import Data.Maybe (Maybe(..))
import Data.Array (zip, (..), length)

import Control.Monad.Eff (Eff)

import DOM (DOM)
import DyGraphs (DyData(Array2D, CSV), defaultDyOpts, newDyGraph, RunDyGraph)

import Util.DOM (tryWithNode, setText)

--plotData :: DyData
--plotData = Array2D $ [ [0.0,  0.0 ,  0.0 ,  0.0]
--                     , [0.1,  0.1 , -0.2 ,  0.3]
--                     , [0.2, -0.1 ,  0.2 ,  0.3]
--                     , [0.3,  0.15, -0.25, -0.3]
--                     ]

toDyGraph :: Array Number -> Array Number -> DyData
toDyGraph s1 s2 = zip (1 .. length s1) (zip s1 s2) <#> (\(Tuple i (Tuple e1 e2)) -> [toNumber i, e1, e2]) # Array2D

main :: forall eff. Eff ( dom :: DOM, runDyGraph :: RunDyGraph | eff ) Unit
main = do
  tryWithNode "#graph" $ \d ->
    newDyGraph d (toDyGraph series1 series2) defaultDyOpts
      { title = Just "Data"
        , xlabel = Just "Value"
        , ylabel = Just "Day"
--      , showRoller = Just true
--      , errorBars = Just true
--      , stepPlot = Just true
--      , clickCallback = Just $ \e x pts -> do
--          tryWithNode "#msg" $ setText "Canvas clicked!"
--      , highlightCallback = Just $ \e x pts r s -> do
--          tryWithNode "#msg" $ setText "Point highlighted!"
      }

series1 :: Array Number
series1 = [ 106.1616296,98.92188981,96.47125453,96.46867633,101.455799,102.2368421,114.709233,107.0379752,101.3964413,103.9022896,92.38084853,105.2355647,87.15531588,119.241544,111.0962582,97.41282225 ]
series2 :: Array Number
series2 = [ 61.87022328,112.2162175,55.26382685,89.23769414,88.73319089,111.9717193,66.11845016,124.9046659,107.2487974,64.06293035,76.29163772,43.25612068,82.22805411,53.40558767,79.04625267,55.79522371 ]

plotData :: DyData
plotData = CSV "Date,S1,S2\n20070327,106.1616296,10,61.87022328,20\n20070328,98.92188981,10,112.2162175,20\n20070329,96.47125453,10,55.26382685,20\n20070330,96.46867633,10,89.23769414,20\n20070331,101.455799,10,88.73319089,20\n20070401,102.2368421,10,111.9717193,20\n20070402,114.709233,10,66.11845016,20\n20070403,107.0379752,10,124.9046659,20\n20070404,101.3964413,10,107.2487974,20\n20070405,103.9022896,10,64.06293035,20\n20070406,92.38084853,10,76.29163772,20\n20070407,105.2355647,10,43.25612068,20\n20070408,87.15531588,10,82.22805411,20\n20070409,119.241544,10,53.40558767,20\n20070410,111.0962582,10,79.04625267,20\n20070411,97.41282225,10,55.79522371,20\n20070412,110.4098856,10,70.34919858,20\n20070413,95.48858523,10,58.09465885,20\n20070414,103.7645072,10,61.76759124,20\n20070415,114.0212977,10,94.25487399,20\n20070416,98.90731737,10,43.8510704,20\n20070417,115.8103609,10,68.93454671,20\n20070418,101.4229718,10,100.5048537,20\n20070419,119.7953916,10,100.8551717,20\n20070420,92.03600168,10,82.44405091,20\n20070421,112.404753,10,81.862479,20\n20070422,104.0598172,10,51.25240803,20\n20070423,93.16762626,10,86.50150597,20\n20070424,93.20928156,10,90.79233646,20\n20070425,104.136014,10,101.1983895,20\n20070426,98.18476781,10,42.97687292,20\n20070427,121.30867,10,45.99423885,20\n20070428,115.0535369,10,71.61482751,20\n20070429,94.02800918,10,56.23593807,20\n20070430,88.12078238,10,99.37836885,20\n20070501,111.701386,10,80.26698813,20\n20070502,98.71472746,10,56.63724899,20\n20070503,103.3637223,10,100.0523329,20\n20070504,111.6026032,10,77.20770925,20\n20070505,99.46561486,10,82.21633151,20\n20070506,77.79586792,10,105.6063557,20\n20070507,104.1138026,10,50.60523748,20\n20070508,123.4131312,10,77.74221003,20\n20070509,94.32396233,10,81.54578775,20\n20070510,88.11084867,10,57.1634531,20\n20070511,105.0146395,10,99.34621334,20\n20070512,100.8853319,10,84.48430657,20\n20070513,100.7413655,10,66.074512,20\n20070514,91.68657124,10,96.21918201,20\n20070515,114.0934432,10,102.2575998,20\n20070516,97.62790263,10,130.860343,20\n20070517,112.2869945,10,78.55360448,20\n20070518,95.237059,10,44.73735571,20\n20070519,97.74982437,10,93.49213958,20\n20070520,108.3200771,10,69.77927566,20\n20070521,99.22291666,10,67.96180487,20\n20070522,96.8812573,10,102.4937749,20\n20070523,69.85949755,10,70.41799784,20\n20070524,89.90463376,10,108.9719844,20\n20070525,96.77317828,10,71.22245431,20\n20070526,112.6351225,10,122.2939205,20\n20070527,104.8802331,10,75.94745964,20\n20070528,108.8299888,10,66.43187404,20\n20070529,113.3873522,10,85.29884994,20\n20070530,94.14963186,10,73.187868,20\n20070531,106.6347116,10,93.19302678,20\n20070601,99.30340961,10,57.9911375,20\n20070602,103.288852,10,46.18402004,20\n20070603,107.427718,10,94.01047945,20\n20070604,86.35903716,10,77.00072527,20\n20070605,101.4704388,10,77.67322242,20\n20070606,95.87053329,10,102.2857356,20\n20070607,116.7234516,10,82.18394369,20\n20070608,88.92636538,10,29.06132698,20\n20070609,99.80039157,10,75.96016198,20\n20070610,99.53045484,10,79.31763008,20\n20070611,96.5316081,10,95.62693954,20\n20070612,84.97387171,10,63.47404718,20\n"
