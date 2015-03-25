import sys, glob
# -*- coding: utf-8 -*-

# question 4.6
# creer histo

# arg 1 : repertoire source

def out(histo):
    print '0',
    for k, val in enumerate(histo):
        if val > 0:
            print ' %s:%s' % (k, str(histo[k])),
    print ''

def process_file(f):
    #histo = {}
    histo = []
    total = 0
    with open(f, "r") as ins:
        for line in ins:
            comp = int(line)
            try:
                histo[comp] += 1.0
            except IndexError:
                histo.insert(comp, 1)
            total += 1
    for k, val in enumerate(histo):
        histo[k] = round(histo[k] / total, 6)
    out(histo)

for line in glob.glob(sys.argv[1] + '/*'):
    process_file(line)
