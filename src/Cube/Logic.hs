module Cube.Logic  where

import Control.Monad.Trans ()

import Cube.Config

import Cube.Types
    (
      Cube(..),
      CubePos (..),
      Points(..),
      Points2D(..),
      Canvas(..),
      Cube2D (..),
      )

worldToScreen :: Canvas -> Points -> Points2D
worldToScreen (Canvas cw ch) (Points px py pz) = Points2D x y
    where
        x = px / pz * cw + (cw / 2)
        y = py / pz * cw + (ch / 2)

toCube2D :: Cube -> Cube2D
toCube2D (Cube cubPos cubeStart cubeSize canvas) = Cube2D front back left right top bottom
    where
        blr = worldToScreen canvas (cubeBL cubPos)
        brr = worldToScreen canvas (cubeBR cubPos)
        tlr = worldToScreen canvas (cubeTL cubPos)
        trr = worldToScreen canvas (cubeTR cubPos)
        blrz = worldToScreen canvas (cubeBLZ cubPos)
        brrz = worldToScreen canvas (cubeBRZ cubPos)
        tlrz = worldToScreen canvas (cubeTLZ cubPos)
        trrz = worldToScreen canvas (cubeTRZ cubPos)
        front = [blr, brr, trr, tlr]
        back  = [blrz, brrz, trrz, tlrz]
        left  = [blr, tlr, tlrz, blrz]
        right = [brr, trr, trrz, brrz]
        top   = [tlr, trr, trrz, tlrz]
        bottom = [blr, brr, brrz, blrz]


rotateX :: Points -> Points -> Points
rotateX newPoints initPoints = Points x' y' z'
    where
        z = pointZ newPoints - pointZ initPoints
        y = pointY newPoints - pointY initPoints
        x' = pointX newPoints
        y' = y * cos angleX - z * sin angleX + pointY initPoints
        z' = y * sin angleX + z * cos angleX + pointZ initPoints

rotateY :: Points -> Points -> Points
rotateY newPoints initPoints = Points x' y' z'
    where
        z = pointZ newPoints - pointZ initPoints
        x = pointX newPoints - pointX initPoints
        x' = x * cos angleY + z * sin angleY + pointX initPoints
        y' = pointY newPoints
        z' = negate (x * sin angleY) + z * cos angleY + pointZ initPoints

rotateZ :: Points -> Points -> Points
rotateZ newPoints initPoints = Points x' y' z'
    where
        x = pointX newPoints - pointX initPoints
        y = pointY newPoints - pointY initPoints
        x' = x * cos angleZ - (y * sin angleZ) + pointX initPoints
        y' = x * sin angleZ + y * cos angleZ + pointY initPoints
        z' = pointZ newPoints

rotateCubeX :: Cube -> Cube
rotateCubeX (Cube cubPos cubeStart cubeSize initCanvas) = Cube cubePos' cubeStart cubeSize initCanvas
    where
    cubeBL'  = rotateX (cubeBL cubPos) cubeStart
    cubeBR'  = rotateX (cubeBR cubPos) cubeStart
    cubeTL'  = rotateX (cubeTL cubPos) cubeStart
    cubeTR'  = rotateX (cubeTR cubPos) cubeStart
    cubeBLZ' = rotateX (cubeBLZ cubPos) cubeStart
    cubeBRZ' = rotateX (cubeBRZ cubPos) cubeStart
    cubeTLZ' = rotateX (cubeTLZ cubPos) cubeStart
    cubeTRZ' = rotateX (cubeTRZ cubPos) cubeStart
    cubePos' = CubePos cubeBL' cubeBR' cubeTL' cubeTR' cubeBLZ' cubeBRZ' cubeTLZ' cubeTRZ'

rotateCubeY :: Cube -> Cube
rotateCubeY (Cube cubPos cubeStart cubeSize initCanvas) = Cube cubePos' cubeStart cubeSize initCanvas
    where
    cubeBL'  = rotateY (cubeBL cubPos) cubeStart
    cubeBR'  = rotateY (cubeBR cubPos) cubeStart
    cubeTL'  = rotateY (cubeTL cubPos) cubeStart
    cubeTR'  = rotateY (cubeTR cubPos) cubeStart
    cubeBLZ' = rotateY (cubeBLZ cubPos) cubeStart
    cubeBRZ' = rotateY (cubeBRZ cubPos) cubeStart
    cubeTLZ' = rotateY (cubeTLZ cubPos) cubeStart
    cubeTRZ' = rotateY (cubeTRZ cubPos) cubeStart
    cubePos' = CubePos cubeBL' cubeBR' cubeTL' cubeTR' cubeBLZ' cubeBRZ' cubeTLZ' cubeTRZ'


rotateCubeZ :: Cube -> Cube
rotateCubeZ (Cube cubPos cubeStart cubeSize initCanvas)  = Cube cubePos' cubeStart cubeSize initCanvas
    where
    cubeBL' = rotateZ (cubeBL cubPos) cubeStart
    cubeBR' = rotateZ (cubeBR cubPos) cubeStart
    cubeTL' = rotateZ (cubeTL cubPos) cubeStart
    cubeTR' = rotateZ (cubeTR cubPos) cubeStart
    cubeBLZ' = rotateZ (cubeBLZ cubPos) cubeStart
    cubeBRZ' = rotateZ (cubeBRZ cubPos) cubeStart
    cubeTLZ' = rotateZ (cubeTLZ cubPos) cubeStart
    cubeTRZ' = rotateZ (cubeTRZ cubPos) cubeStart
    cubePos' = CubePos cubeBL' cubeBR' cubeTL' cubeTR' cubeBLZ' cubeBRZ' cubeTLZ' cubeTRZ'

rotateCube :: Cube -> Cube
rotateCube = rotateCubeZ . rotateCubeY . rotateCubeX

createCube :: Points -> Float -> Canvas -> Cube
createCube initPoints@(Points x y z) initSize initCanvas = Cube (CubePos bl br tl tr blz brz tlz trz) initPoints initSize initCanvas
    where
        bl = Points (x-initSize/2) (y-initSize/2) (z-initSize/2)
        br = Points (x+initSize/2) (y-initSize/2) (z-initSize/2)
        tl = Points (x-initSize/2) (y+initSize/2) (z-initSize/2)
        tr = Points (x+initSize/2) (y+initSize/2) (z-initSize/2)
        blz = Points (x-initSize/2) (y-initSize/2) (z+initSize/2)
        brz = Points (x+initSize/2) (y-initSize/2) (z+initSize/2)
        tlz = Points (x-initSize/2) (y+initSize/2) (z+initSize/2)
        trz = Points (x+initSize/2) (y+initSize/2) (z+initSize/2)
