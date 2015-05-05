WORKSPACE = Example/Artsy-UIButtons.xcworkspace
SCHEME = Artsy-UIButtons

all: ci

build:
	set -o pipefail && xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) -sdk iphonesimulator build | bundle exec xcpretty -c

clean:
	xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) clean

test:
	set -o pipefail && xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration Debug test -sdk iphonesimulator -destination platform='iOS Simulator',OS='8.1',name='iPhone 6' | bundle exec second_curtain | bundle exec xcpretty -c --test

ci: build
