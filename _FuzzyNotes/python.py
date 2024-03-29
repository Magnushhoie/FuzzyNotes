## Python commands ##

__python run from bash terminal__
# run python code from bash
python -c "print("Hello world!")"

__python for loop__
numbers = [1,2,3,4,5]
for n in numbers:
    print(n*2)

__python get unique elements from list__
set(list_x)

__python invert dict / dictionary__
# https://stackoverflow.com/questions/483666/reverse-invert-a-dictionary-mapping
inv_map = {v: k for k, v in my_map.items()}

__python update / dictionary key name__
dictionary[new_key] = dictionary.pop(old_key)

__python print without newline, no newline__
print('Hello World!', end='')

__python check version of installed package__
package.__version__
sns.__version__
# From terminal
python --version

__python get root project directory even in jupyter notebook__
import os
root = Path(os.getcwd()).parent

__python list comprehension__
# Short version of a for loop
numbers = [1,2,3,4,5]
[print(n*2) for n in numbers]

__python safer evaluation__
import ast
ast.literal_eval(vals)

__python import from path__
# Add new folder to python path for importing modules, and show python paths
import sys
sys.path.insert(0, "/home/admin")
sys.path.insert(0, "/home/admin/scripts")
print(sys.path)

__python get time, time duration__
from datetime import date
today = date.today()

from datetime import datetime
start = datetime.now()
end = datetime.now()
duration = str(end - start)

__python debug__
import pdb
pdb.set_trace()

__python read files from zip file directly, json from zip__
# https://www.geeksforgeeks.org/working-zip-files-python/
import json
from zipfile import ZipFile

zip_file = "data/2021-02-05.zip"
zip_zip_filenames = ZipFile(file_name, 'r').namelist()

out_df = pd.DataFrame(columns = ["NOPE"])

for filename in zip_zip_filenames:
    file = ZipFile(file_name, 'r').read(filename)
    js = json.loads(file)

    NOPE = get_NOPE(js, v = False)
    out_df.loc[filename] = NOPE
    print(filename, NOPE)

__python convert images to gif animation (pdf to png to gif)__
import os, glob
import natsort
from pdf2image import convert_from_path
pdf_file_list = natsort.natsorted(glob.glob("figures/*.pdf"))

for input_filename in pdf_file_list:
    pages = convert_from_path(input_filename, 100)
    for page in pages:
        output_filename = input_filename+".png"
        print(output_filename)
        page.save(output_filename, "PNG")

# Convert to gif
import imageio
from pathlib import Path
images = natsort.natsorted(glob.glob("figures/*.png"))
image_list = []
for file_name in images:
    image_list.append(imageio.imread(file_name))

# Save
imageio.mimsave('figures/animated_from_images.gif', image_list, fps = 1)

__python import file using argparse__
# Make script take input arguments
from argparse import ArgumentParser
import os

def is_valid_file(parser, arg):
    if not os.path.exists(arg):
        parser.error("Input file %s does not exist" % arg)
    else:
        return open(arg, 'r')  # return an open file handle

parser = ArgumentParser(description="Converts input file to output file")
parser.add_argument("-i", dest="INPUT_FILE", required=True,
                    help="Input file path", metavar="FILE",
                    type=lambda x: is_valid_file(parser, x))
parser.add_argument("-o", dest="OUTPUT_FILE", required=True,
                    help="Output file path", metavar="FILE",
                    type=lambda x: is_valid_file(parser, x))
args = parser.parse_args()

INFILE = args.INPUT_FILE.name
OUTFILE = args.OUTPUT_FILE.name

__python parallel for loop__
# https://stackoverflow.com/questions/9786102/how-do-i-parallelize-a-simple-python-loop
from joblib import Parallel, delayed
def process(i):
    return i * i

results = Parallel(n_jobs=2)(delayed(process)(i) for i in range(10))
print(results)  # prints [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
