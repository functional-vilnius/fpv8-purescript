module Main where

import Prelude (Unit, (<$>), ($), bind, show, (-), (+), (*), (/), (++))
import Data.Int (toNumber)
import Data.Maybe.Unsafe (fromJust)
import Data.Array ((..), zip, length, sort)
import Data.Tuple (Tuple(..))
import Data.Foldable (maximum, mconcat)
import Control.Monad.Eff (Eff)
import Signal.Channel (CHANNEL)

import DOM (DOM)
import Text.Smolder.HTML5.SVG as S
import Text.Smolder.Markup (Markup() ,(!), text)

import Flare (UI(), boolean)
import Flare.Smolder (runFlareHTML)

values :: Array Number
values = [0.08167, 0.01492, 0.02782, 0.04253, 0.12702, 0.02288, 0.02015, 0.06094, 0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, 0.07507, 0.01929, 0.00095, 0.05987, 0.06327, 0.09056, 0.02758, 0.00978, 0.02360, 0.00150, 0.01974, 0.00074]

ratio :: Number
ratio = 450.0 / (fromJust $ maximum values)

xaxis :: Markup
xaxis = S.g ! S.class' "x axis" ! S.transform "translate(0,450)" $ do
          mconcat $ drawTick <$> zip (0 .. length values) values
          where
          drawTick (Tuple i s) = S.g ! S.class' "tick" ! S.transform ("translate(" ++ (show (25.5+ toNumber (i*34))) ++ ",0)") ! S.style "opacity: 1;" $ do
            S.line ! S.y2 "6" ! S.x2 "0"
            S.text' ! S.dy ".71em" ! S.y "9" ! S.x "0" ! S.style "text-anchor: middle;" $ text "C"

barchart :: Boolean -> Markup
barchart h = S.svg ! S.width "960" ! S.height "500" $ do
               S.g ! S.transform "translate(40,20)" $ do
                 xaxis
                 mconcat $ drawBar <$> zip (0 .. length values) (if h then sort values else values)
                 where
                 drawBar (Tuple i v) = S.rect ! S.class' "bar" ! S.width (show 31) ! S.x (show (10+i*34)) ! S.y (show (450.0 - ratio * v)) ! S.height (show (ratio * v))

ui :: forall eff. UI eff Markup
ui = barchart <$> boolean "sorted" false

main :: forall eff. Eff(dom :: DOM, channel :: CHANNEL | eff) Unit
main = runFlareHTML "controls" "output" ui
