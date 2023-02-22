def isConsonant(s, i):
  #s is a string, i is the index, so s[i] is the letter
  if s[i] in 'aeiou': #if the letter is a, e, i, o, or u, it's a vowel
    return False
  elif s[i] == 'y' and i != 0: #if the letter is y but not the first letter, it's a vowel
    return False
  return True

def translateWord(word):
  if len(word) == 0: #if the string has no length, return nothing
    return ""
  word = word.lower() #lowercase the word so that it doesn't break the isConsonant fxn
  charIndex = 0
  while isConsonant(word, charIndex): #this while function will loop through the word until it gets a vowel
    charIndex += 1
  if (charIndex == 0): #if the loop found a vowel immediately (if the first letter is a vowel)
    return word+"-yay" #just return the word and then "-yay"
  return word[charIndex:]+"-"+word[:charIndex]+"ay" 
  #otherwise, return the last part of the word, then a hyphen, then the start of the word, then "ay"

def translateSentence(sentence):
  #this first
  words = []
  otherPunctMarks = ""
  while len(sentence)>0: 
    going = True
    charIndex = 0
    while going:
      if charIndex >= len(sentence):
        words.append(sentence)
        sentence = ""
        going = False
      elif sentence[charIndex].lower() in "abcdefghijklmnopqrstuvwxyz'":
        #keep going
        charIndex += 1
      else:
        #word is over
        words.append(sentence[:charIndex])
        otherPunctMarks += sentence[charIndex]
        sentence = sentence[charIndex+1:]
        going = False
  entencesay = ""
  ordsway = []
  for i in range(len(words)):
    ordsway.append(translateWord(words[i]))
  for i in range(len(words)-1):
    entencesay += ordsway[i] + otherPunctMarks[i]
  entencesay += ordsway[len(words)-1]
  if len(otherPunctMarks)==len(words):
    entencesay += otherPunctMarks[len(words)-1]
  print(entencesay)
  print("\n")

while True:
  translateSentence(input("Type in what you want to translate: \n--"))
  