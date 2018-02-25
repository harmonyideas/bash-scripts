# copy Entire Directory (Recursively)
$ scp -r source_file_path destination_file_path

# specify identiy file
$ scp -i /path/to/private_key.pem ~/localfile.txt user@host:/some/path/localfile.txt

# copy from local host to remote host
$ scp localfile user@host:/remotefolder/file

# copy from remote host to local host
$ scp user@host:/path/to/remotefile localfolder/file
