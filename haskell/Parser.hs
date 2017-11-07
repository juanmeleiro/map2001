{-|
Module      : Parser
Description : STL Parsing
Copyright   : (c) Juan Meleiro, 2017
Maintainer  : juan.meleiro@me.com
Stability   : experimental

This module implements functions relative to parsing of STL source files into
`Solid` objects.
-}
module Parser (parse) where
import Geometry


-- |Takes as input a `String` which is a well-formed STL source file and returns
-- a `Solid` representing the contents of that file.
parse :: String -> Solid
parse = Solid . (solid . (tokens ""))

-- | Transforms list of characters into list of tokens, which are separated by whitespace
tokens :: String -> String -> [String]
tokens "" (' ':cs) = tokens "" cs
tokens "" ('\n':cs) = tokens "" cs
tokens t (' ':cs) = t : (tokens "" cs)
tokens t ('\n':cs) = t : (tokens "" cs)
tokens t (c:cs) = tokens (t ++ [c]) cs
tokens t [] = [t]

solid :: [String] -> [Face]
solid ("solid":name:tokens) = face tokens

face :: [String] -> [Face]
face ("facet":"normal":n1:n2:n3
        :"outer":"loop"
          :"vertex":x1:y1:z1
          :"vertex":x2:y2:z2
          :"vertex":x3:y3:z3
        :"endloop"
      :"endfacet":fs) = (Face
                          (Point (read n1) (read n2) (read n3))
                          (Point (read x1) (read y1) (read z1))
                          (Point (read x2) (read y2) (read z2))
                          (Point (read x3) (read y3) (read z3))) : (face fs)
face ("endsolid":name) = []
face s = error ("Syntax Error. Context: " ++ (join s))

join :: [String] -> String
join [] = ""
join (w:ws) = w ++ " " ++ join ws
