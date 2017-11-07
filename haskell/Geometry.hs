{-|
Module      : Geometry
Description : Geometry types and functions
Copyright   : (c) Juan Meleiro, 2017
Maintainer  : juan.meleiro@me.com
Stability   : experimental

Here are implemented types relative to geometric notions: `Point`s, `Face`s and
`Solid`s, besides functions involving `Point`s (which are really vectors).
-}
module Geometry where

-- * Types

-- | A point in 3D Euclidian Space
data Point = Point Float Float Float deriving (Eq, Show)

-- | A face is defined by a normal and three vertices
data Face = Face {normal, p, q, r :: Point} deriving (Eq, Show)

-- |A `Solid` is a list of `Face`s
data Solid = Solid [Face] deriving (Eq, Show)

-- * `Point` Functions

-- |Returns angle between two `Point`s
angle :: Point -> Point -> Float
angle p q = acos ((dot p q)/(norm p * norm q))

-- |Dot product of two `Point`s
dot :: Point -> Point -> Float
dot (Point x y z) (Point x' y' z') = x*x' + y*y' + z*z'

-- |Norm of a `Point`
norm :: Point -> Float
norm (Point x y z) = sqrt (x*x + y*y + z*z)

-- |Euclidian distance between two `Point`s
distance :: Point -> Point -> Float
distance p q = norm (p - q)

instance Num Point where
  (+) (Point x y z) (Point x' y' z') = Point (x + x') (y + y') (z + z')
  (-) (Point x y z) (Point x' y' z') = Point (x - x') (y - y') (z - z')
  (*) (Point x y z) (Point x' y' z') = Point (x*x') (y*y') (z*z')
  abs = id
  signum (Point 0 0 0) = 0
  signum _ = 1
  fromInteger n = let x = fromInteger n in (Point x x x)
