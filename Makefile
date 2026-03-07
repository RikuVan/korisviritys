.PHONY: run build clean test analyze deps

# Run the app in debug mode
run:
	fvm flutter run -d macos

# Build release macOS app and install to /Applications
build:
	fvm flutter build macos --release
	rm -rf /Applications/korisviritys.app
	cp -R build/macos/Build/Products/Release/korisviritys.app /Applications/

# Run tests
test:
	fvm flutter test

# Run Dart analyzer
analyze:
	fvm flutter analyze

# Install dependencies
deps:
	fvm flutter pub get

# Clean build artifacts
clean:
	fvm flutter clean

# Format code
format:
	fvm dart format lib test
