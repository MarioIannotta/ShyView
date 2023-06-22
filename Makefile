test-ios:
	xcodebuild \
		-scheme ShyView \
		-destination platform="iOS Simulator,name=iPhone 14 Pro,OS=16.0" \
		test | xcpretty && exit 0 \
