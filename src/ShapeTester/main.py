from Box import Box
from Pyramid import Pyramid
from Sphere import Sphere

def program():
  print("Welcome!")
  going = True
  while going:
    x = input("What object would you like to find values for? If you'd like to exit, just type 'exit'.\n--")
    x = x.lower()
    a = "What is the value for the "
    X = x.capitalize()
    v = X+" volume is "
    s = X+" surface area is "
    print("")
    if (x == "exit"):
      print("Well if you ever want to start the program again, just type program().")
      going = False
    elif (x == "box"):
      l = input(a+x+"'s length?\n")
      w = input(a+x+"'s width?\n")
      h = input(a+x+"'s height?\n")
      box1 = Box(l, w, h)
      print(v+ str(box1.calcVol()))
      print(s + str(box1.calcSA()) + "\n\n")
    elif (x == "pyramid"):
      l = input(a+x+"'s length?\n")
      w = input(a+x+"'s width?\n")
      h = input(a+x+"'s height?\n")
      pyr1 = Pyramid(l, w, h)
      print(v+ str(pyr1.calcVol()))
      print(s + str(pyr1.calcSA()))
    elif (x == "sphere"):
      sfr1 = Sphere(input(a+x+"'s radius?\n"))
      print(v + str(sfr1.calcVol()))
      print(s + str(sfr1.calcSA()))
    else:
      print("Object type not understood, please try again.")
program()