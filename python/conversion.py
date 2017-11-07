# Implements determineConnectors, determineEdges, toOpenSCAD functions and main interface
from pieces import *
from geometry import adjacent
from math import sqrt, cos, sin, pi

def determineConnectors(faces):
    '''Outputs list of ConnectorPiece objects corresponding to connectors for "faces"'''
    connectors = []
    for i in range(len(faces)):
        for j in range(i + 1, len(faces)):
            if adjacent(faces[i], faces[j]):
                connectors.append(ConnectorPiece(faces[i], faces[j]))
    return connectors

def determineEdges(faces):
    '''Outputs list of EdgePiece objects corresponding to each one of the elements of "faces"'''
    edges = []
    for f in faces:
        edges.append(EdgePiece(f, f.p))
        edges.append(EdgePiece(f, f.q))
        edges.append(EdgePiece(f, f.r))
    return edges

def toOpenSCAD(pieces):
    '''Outputs OpenSCAD programm corresponding to the given list of pieces'''

    pieces = sorted([p for p in pieces if isinstance(p, ConnectorPiece)], key=(lambda p: p.angle), reverse=True) + sorted([p for p in pieces if isinstance(p, EdgePiece)], key=lambda p: p.length, reverse=True)
    separation = 15
    num = len([p for p in pieces if isinstance(p, EdgePiece)])

    piece_commands = ''
    x = 0
    for p in pieces:
        piece_commands += 'translate([%f, 0, 0])' % x + p.toOpenSCAD()
        if isinstance(p, EdgePiece):
            x += separation
        elif isinstance(p, ConnectorPiece):
            x += separation

    max_length = max([p.length for p in pieces if isinstance(p, EdgePiece)])
    #straight_connectors = "for (i = [0:" + str(num) + "]) {translate([i*2*WIDTH, " + str(max_length) + ", 0]) color([1, 0, 0])if (i % 2 == 1) {connector(180);}else {mirror([0, 1, 0]) connector(180);}}"
    straight_connectors = "for (i = [0:" + str(num) + "]) {translate([i*4*WIDTH + i, " + repr(max_length) + ", 0]) connector(180); }"
    return piece_commands + straight_connectors
