{-|
Module      : Pieces
Description : Piece types
Copyright   : (c) Juan Meleiro, 2017
Maintainer  : juan.meleiro@me.com
Stability   : experimental

This module implements the two types wich represent pieces: `Connector`s and `Edge`s.
-}
module Pieces where

-- |A `Connector` is defined by it's angle, a `Float`.
data Connector = Connector Float deriving (Eq, Show)

-- |An `Edge` is defined by three `Float`s: a length and two angles.
data Edge = Edge Float Float Float deriving (Eq, Show)
