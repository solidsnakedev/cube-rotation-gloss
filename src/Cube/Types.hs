module Cube.Types where


data Canvas = Canvas
            { canvasWidth :: Float
            , canvasHeigth :: Float
            }
            deriving Show
            
data Points2D = Points2D
            { point2DX :: Float
            , point2DY :: Float
            }
            deriving Show

data Points = Points
            { pointX :: Float
            , pointY :: Float
            , pointZ :: Float
            }
            deriving Show

data Cube = Cube
          { cubPos    :: CubePos
          , cubeStart :: Points
          , cubeSize  :: Float
          , cubeCanvas :: Canvas
          }
          deriving Show

data CubePos = CubePos
             { cubeBL    :: Points
             , cubeBR    :: Points
             , cubeTL    :: Points
             , cubeTR    :: Points
             , cubeBLZ   :: Points
             , cubeBRZ   :: Points
             , cubeTLZ   :: Points
             , cubeTRZ   :: Points
             }
             deriving Show

data Cube2D = Cube2D
            { front  :: [Points2D]
            , back   :: [Points2D]
            , left   :: [Points2D]
            , right  :: [Points2D]
            , top    :: [Points2D]
            , bottom :: [Points2D]
            }
            deriving Show