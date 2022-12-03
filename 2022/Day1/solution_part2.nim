import strutils
var tval: int
var max: array[3, int]

for line in lines "input.txt":
  if line == "": tval = 0
  else: tval += parseInt(line) 
  var 
    repind = -1
    itval = 999999999
  for val in 0..<len max:
    if max[val] < itval: itval = max[val]
    if tval > max[val] and max[val] <= itval:
      repind = val
  if repind != -1: max[repind] = tval

echo max[0] + max[1] + max[2]
