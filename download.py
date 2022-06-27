import subprocess

with open('/home/ubuntu/precisionFDA-NCTR-indel-benchmark/Panel/PanelA_fileIDs.txt') as f:
    linesA = f.read().splitlines()

for entry in linesA:
    subprocess.call(["./pfda", "download", "--file-id", entry, "--output", "/mnt/d/FDA/Panel-A/"])

with open('/home/ubuntu/precisionFDA-NCTR-indel-benchmark/Panel/PanelB_fileIDs.txt') as f:
    linesB = f.read().splitlines()

for entry in linesB:
    subprocess.call(["./pfda", "download", "--file-id", entry, "--output", "/mnt/d/FDA/Panel-B/"])