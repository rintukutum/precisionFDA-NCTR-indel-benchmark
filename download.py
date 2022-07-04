import subprocess

# change the authorization key after every 24 hours
authkey = "clBXL2c2S0lPK1NUQmJzc2R2ZDhRZWJ4N1pYSG9VSEx5b05MNStoSjNJNjJEVzdtS3hHSkpYdzVMVWsxbnRzYnQySGNMSVJqdDZFTkNoMkZtQ0ZCdU1IUlY4d3JoQ1h0ZzdtRVUxZmFESUVKM2RuNDhUZDdIVnhTNFlkam56NUlmZVZDMktXZlFBcTd0aENWc0ZCK3E5cXR5VmFka2V3bzJpaEd2TWIxREhxcEJQM0xlOFlMY1V3SWo0OUZ6SlI1TDdiYzUxUkQyUW1BbFFCclNkZCtVQT09LS1JVUtiMXk0TTBLZnMwd21uMzdpM3RnPT0=--f90948f5afc1a3c1882fdcbd9d0fb4fd1afa1ff7"

PanelA_fileID = "Panel/PanelA_fileIDs.txt"
PanelB_fileID = "Panel/PanelB_fileIDs.txt"
PanelA = "/storage/bic/data/pfda-nctr/data/panel-a"
PanelB = "/storage/bic/data/pfda-nctr/data/panel-b"

with open(PanelA_fileID) as f:
    linesA = f.read().splitlines()

for entry in linesA:
    subprocess.call(["./pfda", "download", "--key", authkey, "--file-id", entry, "--output", PanelA])

with open(PanelB_fileID) as f:
    linesB = f.read().splitlines()

for entry in linesB:
    subprocess.call(["./pfda", "download", "--key", authkey, "--file-id", entry, "--output", PanelB])