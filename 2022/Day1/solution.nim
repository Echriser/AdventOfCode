import strutils
var tval, max: int

for line in lines "input.txt":
  if line == "": tval = 0
  else: tval += parseInt(line) 
  if tval > max: max = tval

echo max
