module Cube.Render where

import Graphics.Gloss
import Graphics.Gloss.Data.Picture (Path(..))
import Graphics.Gloss.Data.ViewPort
import Cube.Logic
import Cube.Types

toPicture :: Cube2D -> Picture
toPicture (Cube2D front back left right top bottom) =
    Pictures 
    [ color white  $ lineLoop $ (\(Points2D x y) -> (x,y)) <$> front
    , color red    $ lineLoop $ (\(Points2D x y) -> (x,y)) <$> back
    , color green  $ lineLoop $ (\(Points2D x y) -> (x,y)) <$> left
    , color blue   $ lineLoop $ (\(Points2D x y) -> (x,y)) <$> right
    , color yellow $ lineLoop $ (\(Points2D x y) -> (x,y)) <$> top
    , color cyan   $ lineLoop $ (\(Points2D x y) -> (x,y)) <$> bottom
    ]

renderCube :: Cube -> Picture
renderCube =  toPicture . toCube2D

updateCube :: ViewPort -> Float -> Cube -> Cube
updateCube _ _ cube = rotateCubeZ $ rotateCubeX cube