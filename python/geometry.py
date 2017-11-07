# Implements Vertex, Face and Solid classes; angle and adjacent functions
from math import acos, sqrt

class Vertex:
    '''3D Vector'''

    def __init__(self, x, y, z):
        self.x = float(x)
        self.y = float(y)
        self.z = float(z)

    def __repr__(self):
        return 'Vertex(%s, %s, %s)' % (self.x, self.y, self.z)

    def __str__(self):
        return 'Vertex(%s, %s, %s)' % (self.x, self.y, self.z)

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

    def __add__(self, other):
        return Vertex(self.x + other.x, self.y + other.y, self.z + other.z)

    def __sub__(self, other):
        return Vertex(self.x - other.x, self.y - other.y, self.z - other.z)

    def __rmul__(self, other):
        return Vertex(other*self.x, other*self.y, other*self.z)

    def size(self):
        x = self.x
        y = self.y
        z = self.z
        return sqrt(x*x + y*y + z*z)

    def __hash__(self):
        return (self.x, self.y, self.z).__hash__()

    def dot(self, other):
        return self.x*other.x + self.y*other.y + self.z*other.z

    def components(self):
        return [self.x, self.y, self.z]

def angle(p, q, r=None):
    if r: # Angle between 2 vectors passing through another
        a = p - q
        b = r - q
    else: # Angle between 2 vectors passing through origin
        a = p
        b = q
    return acos(a.dot(b)/(a.size() * b.size()))

class Face:
    '''Face composed of 3 vertices, normal and a name'''

    def __init__(self, p, q, r, n, name):
        self.p = p
        self.q = q
        self.r = r
        self.normal = n
        self.name = name

    def vertices(self):
        return {self.p, self.q, self.r}

    def __and__(self, other):
        return self.vertices() & other.vertices()

    def __sub__(self, other):
        return self.vertices() - other.vertices()

    def __xor__(self, other):
        return self.vertices() ^ other.vertices()

    def __rmul__(self, other):
        return Face(other*self.p, other*self.q, other*self.r, self.normal, self.name)

    def __repr__(self):
        return 'Face(%s, %s, %s, %s, %s)' % (repr(self.p), repr(self.q), repr(self.r), repr(self.normal), repr(self.name))

def adjacent(f1, f2):
    return len(f1 & f2) == 2

class Solid:
    '''Set of faces and a name'''

    def __init__(self, name, faces):
        self.name = name
        self.faces = faces

    def __repr__(self):
        return str(self)

    def __str__(self):
        return 'Solid(%s, %s)' % (repr(self.name), repr(self.faces))

    def __rmul__(self, other):
        return Solid(str(other) + "*" + self.name, [other*f for f in self.faces])

    def fromFile(file_name):
        parser = ASCIISTLParser(file_name)
        return Solid(parser.getSolid())
