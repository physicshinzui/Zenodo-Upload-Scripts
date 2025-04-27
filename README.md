
# Requirements
```
brew install jq # for json parser
```

# 1. Create a token

![image](https://github.com/user-attachments/assets/8200c251-61f5-455f-9c4c-734dcfddbf24)


# How to use scripts.
```bash
bash create_empty_draft.sh
# You can create an empty draft in Your Zenodo dashboard.
# and then sppeficying a file path you want to upload, exexute:
bash upload_files.sh [file-path]
```
Afterwards, please make sure if there exists a file in your Zenodo repo.
Probably, you want to add additional information on the Zenodo repo via Web UI.


# Explanation of detailed procedure written in the scripts
You may not need to know the detailed procedure written in the scripts, 
I explain what I implemented as follows.

## 1. Create a New deposition (Draft Record)

Execute the following line:
```bash 
curl -H "Content-Type: application/json" \
     -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
     -X POST \
     -d '{}' \
     https://zenodo.org/api/deposit/depositions
```
> [!note]
> You need to WRITE `YOUR_ACCESS_TOKEN`.

### Explanation of options
- `Bearer` specifies the authentication scheme being used. 
- `YOUR_ACCESS_TOKEN` is the one you generated at the beginning.
- `-X` : specifies HTTP method to use for the request.
	- `POST` is conventionally used in REST APIs to request that the server crate a new resource a the specified URL.
	- Side note: `GET` is used for retrieve data, `PUT` for upload/replace data, and `DELETE` for remove data.
- `-d` (or `--data`) flag tels `curl` to send the specified data in the body of the HTTP POST request.
	- `'{}'` is the actual data being sent. It's a minimal but valid JSON object representing an empty object. 
		- cuz we intend to create an empty draft deposition at the moment!
- `https://zenodo.org/api/deposit/depositions`
	- The URL of the ZEnodo API endpoint that handles the creation of new depositions.
		- `curl` sends the `POST` request with the specified headers and data body to this URL.

> [!note]
>  Write down the bucket URL that is outputted after the execution of the `curl` script above.

After this, you will see the new deposition in your dashboard in zenodo. like 
![image](https://github.com/user-attachments/assets/a763e424-0ab2-4a18-ae1d-3e4daed831d5)

## 2. Upload files to the deposition bucket.
Execute the following line:
```bash
curl --progress-bar -o /dev/null \
     -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
     -X PUT \
     --upload-file "PATH_TO_YOUR_LARGE_FILE" \
     "BUCKET_URL/FILENAME_ON_ZENODO"
```

> [!note]
> You need to write 
> - `YOUR_ACCESS_TOKEN` 
> - `PATH_TO_YOUR_LARGE_FILE` 
> - `BUCKET_URL`: a link written in the  json file outputted from the first script; Look for `"links":{...,"bucket": ...,...}` 
> - `FILENAME_ON_ZENODO`: the file name shown in the Zenodo repo.
