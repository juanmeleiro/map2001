#!/usr/bin/env python3
# Main interface to terminal
from stl import ASCIISTLParser
from conversion import *

if __name__ == '__main__':
    file_name = input("File name: ") or "tetra.stl" # Get file name
    output_file_name = input("Output file: ") or "out.scad"

    out = open(output_file_name, 'w')

    solid = ASCIISTLParser(file_name).getSolid()   # Convert <file_name> into Solid object

    out.write(toOpenSCAD(determineConnectors(solid.faces) + determineEdges(solid.faces)))
