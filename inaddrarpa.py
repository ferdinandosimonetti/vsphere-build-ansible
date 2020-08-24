#!/usr/bin/python3
import sys
from IPy import IP
sep = '.'
indirizzo = sys.argv[1]
ip = IP(indirizzo)
reversename = ip.reverseName().split(sep)[0:-1]
inaddrarpa = sep.join(reversename[1:])
print(inaddrarpa)