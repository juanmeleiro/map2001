# Implements ConnectorPiece and EdgePiece classes

from geometry import angle
from math import degrees, pi


class ConnectorPiece:
    def __init__(self, face1, face2):
        self.face1 = face1
        self.face2 = face2
        self.angle = pi - angle(face1.normal, face2.normal)
        self.name = face1.name + ':' + face2.name

    def __repr__(self):
        return 'ConnectorPiece(%s, %s)' % (repr(self.face1), repr(self.face2))

    def __str__(self):
        return 'Connector(angle=%s, name=%s)' % (repr(self.angle), repr(self.name))

    def toOpenSCAD(self):
        return 'color([1, 0, 0]) connector(%s);\n' % degrees(self.angle)

class EdgePiece:
    def __init__(self, face, point):
        points = list(face.vertices() - {point})
        self.angle1 = angle(points[0], points[1], point)
        self.angle2 = angle(points[1], points[0], point)
        self.length = (points[1] - points[0]).size()
        self.face_name = face.name

    def __repr__(self):
        return str(self)

    def __str__(self):
        return 'EdgePiece(face=%s, angle1=%s, angle2=%s)' % (self.face_name, self.angle1, self.angle2)

    def toOpenSCAD(self):
        return 'color([1, 0, 0]) edge(%f, %f/2, %f/2);\n' % (self.length, degrees(self.angle1), degrees(self.angle2))
