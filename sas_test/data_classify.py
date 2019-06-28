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

injury_f = open("injury_data.txt","w")
death_f = open("death_data.txt","w")
out = open("out_data.txt","r")
age = ['12','13_20','21_30', '31_40', '41_50', '51_60', '61_64','65', 'NONE']
i = 0
while True:
    line = out.readline()
    if not line : break
    line = line.split()
    injury_f.write(age[i]+' serious '+line[4]+'\n');
    injury_f.write(age[i]+' slight '+line[5]+'\n');
    injury_f.write(age[i]+' declare '+line[6]+'\n');
    death_f.write(' '.join(age[i].split('_')))
    death_f.write(' '+line[1]+' ' + line[2]+'\n')
    i+=1
injury_f.close()
death_f.close()
out.close()
           
           
