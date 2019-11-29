import array
import random
import sys

# define the width  (columns) and height (rows) of your image
width = 480
height = 640

# declare 1-d array of unsigned char and assign it random values
buff=array.array('B')

for i in range(0, width*height):
  buff.append(random.randint(0,55))


# open file for writing 
filename = 'x.pgm'

try:
  fout=open(filename, 'wb')
except IOError:
  sys.exit()


# define PGM Header
pgmHeader = 'P5' + '\n' + str(width) + '  ' + str(height) + '  ' + str(255) + '\n'
pgmHeader_byte = bytearray(pgmHeader,'utf-8')
# write the header to the file
fout.write(pgmHeader_byte)

# write the data to the file 
buff.tofile(fout)

# close the file
fout.close()
