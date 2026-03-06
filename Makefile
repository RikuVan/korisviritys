.PHONY: run build clean test analyze deps

# Run the app in debug mode
run:
	flutter run -d macos

# Build release macOS app
build:
	flutter build macos --release

# Run tests
test:
	flutter test

# Run Dart analyzer
analyze:
	flutter analyze

# Install dependencies
deps:
	flutter pub get

# Clean build artifacts
clean:
	flutter clean

# Format code
format:
	dart format lib test
