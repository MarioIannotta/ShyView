test-ios:
	xcodebuild \
		-scheme ShyView \
		-destination platform="iOS Simulator,name=iPhone 15 Pro,OS=17.0" \
		test | xcpretty && exit 0 \
