# use major version from https://github.com/elastic/beats/blob/main/.go-version
FROM golang:1.17
ADD run_build.sh /run_build.sh
ENTRYPOINT ["/run_build.sh"] 
