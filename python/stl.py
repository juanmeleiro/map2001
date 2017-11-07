# STL Reading and Writing Library
# Implements ASCIISTLParser class and asciiSTLWriter function, besides internal classes
import re
from geometry import *

class UnexpectedToken(Exception):
    '''Error used in ASCIIStream'''

    def __init__(self, value):
        self.value = value

    def __str__(self):
        return repr(self.value)

class ASCIIStream:
    '''Internal class for handling tokens of an ASCII STL file'''

    def __init__(self, file_name):
        with open(file_name) as f:
            self.tokens = re.split('[ \n]+', f.read())[:-1]
        self.pointer = 0

    def peek(self):
        return self.tokens[self.pointer]

    def next(self):
        token = self.tokens[self.pointer]
        self.pointer += 1
        return token

    def eat(self, expected):
        token = self.next()
        if not token == expected:
            raise UnexpectedToken(repr(token) + ' at ' + str(self.pointer) + "'th token")

class ASCIISTLParser:
    '''Class for transforming sequence of tokens (in form of ASCIIStream) into a Solid object'''

    def __init__(self, file_name):
        self.tokens = ASCIIStream(file_name)
        self.name = None
        self.faces = []
        self.nextCall = self.stl
        while not self.nextCall == None:
            (self.nextCall)()

    def stl(self):
        self.tokens.eat('solid')
        self.name = self.tokens.next()
        self.nextCall = self.face

    def face(self):
        self.tokens.eat('facet')
        self.tokens.eat('normal')
        n = Vertex(self.tokens.next(), self.tokens.next(), self.tokens.next())
        self.tokens.eat('outer')
        self.tokens.eat('loop')
        v = []
        for i in range(3):
            self.tokens.eat('vertex')
            v.append(Vertex(self.tokens.next(), self.tokens.next(), self.tokens.next()))
        self.tokens.eat('endloop')
        self.tokens.eat('endfacet')
        self.faces.append(Face(v[0], v[1], v[2], n, str(len(self.faces))))
        if self.tokens.peek() == 'facet':
            self.nextCall = self.face
        else:
            self.nextCall = self.end

    def end(self):
        self.tokens.eat('endsolid')
        self.tokens.eat(self.name)
        self.nextCall = None

    def getSolid(self):
        return Solid(self.name, self.faces)

def asciiSTLWriter(solid, indent=2):
    '''Writes STL file for give solid, with indentation given by 'indent' many spaces for each indent level'''
    header = 'solid ' + solid.name + '\n'
    footer = 'endsolid ' + solid.name + '\n'
    faces = []
    for f in solid.faces:
        facet = indent*' ' + 'facet normal ' + str(f.normal.x) + ' ' + str(f.normal.y) + ' ' + str(f.normal.z) + '\n'
        vertices = ''.join([3*indent*' ' + str(v.x) + ' ' + str(v.y) + ' ' + str(v.z) + '\n' for v in f.vertices()])
        face = facet + 2*indent*' ' + 'outer loop\n' + vertices + 2*indent*' ' + 'endloop\n' + indent*' ' + 'endfacet\n'
        faces.append(face)

    return header + ''.join(faces) + footer

class BinaryStream:
    pass

class BinarySTLParser:
    pass

def stlParser(file_name):
    pass
