WORKSPACE = Example/Artsy-UIButtons.xcworkspace
SCHEME = Artsy-UIButtons-Tests

all: ci

build:
	set -o pipefail && xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 6' -sdk iphonesimulator build | bundle exec xcpretty -c

clean:
	xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) clean

test:
	set -o pipefail && xcodebuild -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 6' -sdk iphonesimulator test | bundle exec second_curtain | bundle exec xcpretty -c --test

ci: build
