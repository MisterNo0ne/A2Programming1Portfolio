#!/usr/bin/python3
import math

class Sphere:
  r = 0

  def __init__(self, radiusf):
    self.r = radiusf

  def calcVol(self):
    return round((self.r**3)*math.pi, 2)

  def calcSA(self):
    return round((4 * (self.r**2))*math.pi, 2)
