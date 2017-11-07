{-|
Module      : Conversion
Description : Puts everything together.
Copyright   : (c) Juan Meleiro, 2017
Maintainer  : juan.meleiro@me.com
Stability   : experimental

This module is responsible for putting everthing together: It implements algorithms
for transforming a `Solid` into it's pieces and pieces into OpenSCAD source.
-}
module Conversion (stlToOpenSCAD) where

import Parser
import Geometry
import Pieces

-- * Geometry to Pieces

-- ** Main

-- |From a `Solid` object gives a list of `Edge`s for that `Solid`
solidToEdges :: Solid -> [Edge]
solidToEdges (Solid (f:fs)) = (faceToEdges f) ++ (solidToEdges (Solid fs))
solidToEdges (Solid []) = []

-- |From a `Solid` object gives list of `Connector`s for that `Solid`
solidToConnectors :: Solid -> [Connector]
solidToConnectors (Solid []) = []
solidToConnectors (Solid (f:fs)) = (map (facesToConnector f) fs) ++ solidToConnectors (Solid fs)

-- ** Auxiliary

-- |From three `Point`s forms an `Edge`
pointsToEdge :: Point -> Point -> Point -> Edge
pointsToEdge p q r = Edge (distance p r) (angle (p - q) (r - q)) (angle (p - r) (q - r))

-- |From a `Face` gives three `Edge`s
faceToEdges :: Face  -> [Edge]
faceToEdges (Face _ p q r) = [(pointsToEdge p q r), (pointsToEdge q r p), (pointsToEdge r p q)]

-- |From two `Face`s gives a `Connector`
facesToConnector :: Face -> Face -> Connector
facesToConnector f g = Connector (angle (normal f) (normal g))

-- * Pieces to OpenSCAD

-- ** Main

-- |Transforms a list of pieces into source for OpenSCAD program specifing those pieces
piecesToOpenSCAD :: [Connector] -> [Edge] -> String
piecesToOpenSCAD cs es = connectorsToOpenSCAD 0 cs ++ edgesToOpenSCAD (length cs) es

-- ** Auxiliary

-- |Transforms list of `Connector`s into list of OpenSCAD commands for those objects,
-- preceeded by translates of an ammount dependent on the Int argument
connectorsToOpenSCAD :: Int -> [Connector] -> String
connectorsToOpenSCAD i [] = ""
connectorsToOpenSCAD i (c:cs) = "translate([3*WIDTH*"
                              ++ (show i)
                              ++ ", 0, 0]) "
                              ++ connectorToOpenSCAD c
                              ++ connectorsToOpenSCAD (i+1) cs

-- |Transforms list of `Edge`s into list of OpenSCAD commands for those objects,
-- preceeded by translates of an ammount dependent on the Int argument
edgesToOpenSCAD :: Int -> [Edge] -> String
edgesToOpenSCAD i [] = ""
edgesToOpenSCAD i (e:es) = "translate([3*(WIDTH + SEP/3)*"
                         ++ (show i)
                         ++ ", 0, 0]) "
                         ++ edgeToOpenSCAD e
                         ++ edgesToOpenSCAD (i+1) es

-- |Takes an `Edge` and gives OpenSCAD command for that pieces
edgeToOpenSCAD :: Edge -> String
edgeToOpenSCAD (Edge len ang1 ang2) = "edge("
                                   ++ (show len)
                                   ++ ", "
                                   ++ (show . toDegrees $ ang1)
                                   ++ ", "
                                   ++ (show . toDegrees $ ang2)
                                   ++");\n"

-- |Takes a `Connector` and gives OpenSCAD command for that piece
connectorToOpenSCAD :: Connector -> String
connectorToOpenSCAD (Connector ang) = "connector(" ++ (show . toDegrees $ ang) ++ ");\n"

-- * Pieces to SVG


-- * STL to OpenSCAD

-- |This function takes as input a `String` of stl source and returns OpenSCAD
-- source for the pieces relative to that stl file – in the form of a `String`
stlToOpenSCAD :: String -> String
stlToOpenSCAD program = piecesToOpenSCAD (solidToConnectors solid) (solidToEdges solid)
                        where solid = (parse program)

-- * Auxiliary

-- | Transform radians into degrees
toDegrees :: Float -> Float
toDegrees x = 180*x/pi
