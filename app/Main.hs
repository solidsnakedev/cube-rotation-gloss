{-# LANGUAGE OverloadedStrings #-}
module Main where

import Cube.Config
import Cube.Logic
import Cube.Render
import Graphics.Gloss.Interface.Environment
import Graphics.Gloss


main = do
  --putStrLn "Hello, Haskell!"
  --Cube.Logic.someFunc
  (screenX, screenY) <- getScreenSize
  let display = InWindow "Game" (600, 600) (0, 0)
  let fps = 60

  let initCube = createCube initPoints initSize initCanvas
  simulate display black fps initCube renderCube updateCube
  --renderGame
