#!/usr/bin/python3

class Box:
  w = 0.0
  l = 0.0
  h = 0.0

  def __init__(self, widf, heihtf, lengf):
    self.w = widf
    self.l = lengf
    self.h = heihtf

  def calcVol(self):
    return round(float(self.w) * float(self.l) * float(self.h), 2)

  def calcSA(self):
    return round(2 * ((float(self.w) * float(self.l)) + (float(self.w) * float(self.h)) + (float(self.l) * float(self.h))), 2)
