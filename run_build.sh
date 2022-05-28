#!/bin/bash
BUILD_ARCHS=("arm64" "arm")

echo "Cloning beats repo"
# clone as go get behavior changed
git clone https://github.com/elastic/beats ${GOPATH}/src/github.com/elastic/beats
echo "Checking out version ${VERSION}"
cd /go/src/github.com/elastic/beats/
git checkout -q v${VERSION}

for ARCH in "${BUILD_ARCHS[@]}"
        do
        for BEAT in $(ls -d *beat | egrep -v '(winlogbeat|libbeat|packetbeat)')
                do
                cd /go/src/github.com/elastic/beats/$BEAT
        echo "Building $BEAT for $ARCH"
                GOARCH=$ARCH go build
                [ -f $BEAT ] && cp -v $BEAT /build/$BEAT-${VERSION}-$ARCH
        done
done

exit
