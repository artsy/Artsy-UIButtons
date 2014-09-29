WORKSPACE = Example/Artsy-UIButtons.xcworkspace
SCHEME = Artsy-UIButtons

all: ci

build: set -o pipefail && xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) -sdk iphonesimulator build | xcpretty -c

clean: xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) clean

test: set -o pipefail && xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration Debug test -sdk iphonesimulator | second_curtain | xcpretty -c --test

ci: build
