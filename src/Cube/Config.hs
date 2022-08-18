module Cube.Config where

import Cube.Types

angleX :: Float
angleX = 2 * pi / 360

angleY :: Float
angleY = 2 * pi / 720

angleZ :: Float
angleZ = 2 * pi / 1480

initSize :: Float
initSize = 2

initPoints :: Points
initPoints = Points 0 0 6

initCanvas :: Canvas
initCanvas = Canvas 200 200