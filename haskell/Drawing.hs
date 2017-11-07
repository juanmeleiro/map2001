{-|
Module      : Drawing
Description : Implements data types for drawing objects to SVG.
Copyright   : (c) Juan Meleiro, 2017
Maintainer  : juan.meleiro@me.com
Stability   : experimental

<Description>
-}

module Drawing where

data Point2D = Point2D Float Float deriving (Eq, Show)
data Line = Line Point2D Point2D deriving (Eq, Show)
