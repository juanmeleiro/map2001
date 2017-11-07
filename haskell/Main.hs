-- |
-- Module      : Main
-- Description : Implements IO
-- Copyright   : (c) Juan Meleiro, 2017
-- Maintainer  : juan.meleiro@me.com
-- Stability   : experimental
--
-- This module only implements the IO for the project. This is what's called when the
-- whole program is called. Asks for a source and targe paths, and does some processing.

module Main where
import Conversion -- for stlToOpenSCAD
import System.IO -- Only for hFLush stdout

main = do putStr "Input file path: "
          hFlush stdout
          in_file_path <- getLine
          putStr "Output file path: "
          hFlush stdout
          out_file_path <- getLine
          in_file <- readFile in_file_path
          result <- return $ stlToOpenSCAD in_file
          writeFile out_file_path result
