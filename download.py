from multiprocessing import process
import subprocess
import multiprocessing

# change the authorization key after every 24 hours
authkey = "UjNPVXIwNGVZR1kzM2lieW84azh2VWxBZW52WmV5eVZQeDNDU0pyNVRzV0VDL3ZReU9XYXVFQ0dmS2xrN0E3cEYvQTcyc0JQZWMzUlBjblFNSENJUkNMVFcrb0c5dnVnRWZIT0VyRkFSU0tQVkU0THVKUVYwd21IUERoTkVuUGg1eEpSVHFqUStZUXFkTThJRGNsTUV2N1dtaGF5S0JZR2pGdFB3YzB1L1VUcmNNKzk3ejM0VkpyK2hsNVo0ekp1NmZCQjYrVHlyOXBMRWhsQ1NOUDF4Zz09LS1hQ3E4L2NHNzczOTJVa0ZLSndFQTZ3PT0=--5a3407f969f0d9a5c1b30f2c54b33e3548b70a4b"

file_id = "Panel/FileID.txt"
storage = "/mnt/d/Oncopanel-Data/"

def multiprocessing_func(x):
    subprocess.call(["./pfda", "download", "--key", authkey, "--file-id", x, "--output", storage])

with open(file_id) as f:
    id = f.read().splitlines()

processes = []

for entry in id:
    p = multiprocessing.Process(target=multiprocessing_func, args=(entry,))
    processes.append(p)
    p.start()

for process in processes:
    process.join()