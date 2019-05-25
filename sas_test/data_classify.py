f = open("data.txt","r")
line = f.readline()
d = dict()
while True:
    line = f.readline()
    if not line : break
    line = line.split()
    if line[2] not in d.keys():
        d[line[2]] = [a for a in line[3:]]
    else:
        d[line[2]] = [str(int(a) + int(b)) for a,b in zip(d[line[2]], line[3:])]

out = open("out_data.txt","w")
for elt in d.keys():
    out.write(elt+' '+' '.join(d[elt])+'\n')
out.close()
f.close()
