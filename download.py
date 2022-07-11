import subprocess

# change the authorization key after every 24 hours
authkey = "WUJmUmxGRWhCUEtXcUJKSEZYZ05HNXNNQllEM29TQ0tBRmtBN2RnbXJnUUh1MXFkQVJYdERCNERTNDBUV3FJbTdvVnd6YjFFb3RiQ1BHODhlTThMV3h1Zm9tZDcxNUxxa3ZLZ0xJZk8vMk15dXV1UHJiQlVmUW1uU2xBeU0zRiszL2JoaDlXak9yQ1JWazlDaTlzdWFWdFZ1b3Q1L0ZEbzRJWlNwK2REYzRQUGF2Qm5XSGpYZm55WnF0WjNoeW1MSDZWcjBRVnNOSERISGlaa25UcDZOZz09LS02clhWc3orN2cyK2ljS3ZwRGxsUnZnPT0=--f6322b37720554ef82bcecaef991c27fba59d58e"

PanelA_fileID = "Panel/PanelA_fileIDs.txt"
PanelB_fileID = "Panel/PanelB_fileIDs.txt"
PanelA = "/mnt/d/Panel-A/"
PanelB = "/mnt/d/Panel-B/"

with open(PanelA_fileID) as f:
    linesA = f.read().splitlines()

for entry in linesA:
    subprocess.call(["./pfda", "download", "--key", authkey, "--file-id", entry, "--output", PanelA])

with open(PanelB_fileID) as f:
    linesB = f.read().splitlines()

for entry in linesB:
    subprocess.call(["./pfda", "download", "--key", authkey, "--file-id", entry, "--output", PanelB])