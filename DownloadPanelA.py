import os
import subprocess

with open('panelA.txt') as f:
    lines = f.read().splitlines()

for entry in lines:
    subprocess.call(["./pfda", "download", "--file-id", entry, "--output", "/mnt/d/FDA/"])