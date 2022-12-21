import glob
import hashlib

filenames = glob.glob()

for filename in filenames:
    with open(filename, 'rb') as inputfile:
        data = inputfile.read()
        print(filename, hashlib.md5(data).hexdigest())