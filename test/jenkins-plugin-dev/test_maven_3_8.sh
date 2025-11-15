#!/bin/bash

set -e

# Import test library
source dev-container-features-test-lib

echo "Testing Maven 3.8 installation..."

# Test that Maven is installed
check "maven-installed" bash -c "mvn --version"

# Test that Maven version is 3.8.x
check "maven-version-3-8" bash -c "mvn --version | grep -q 'Apache Maven 3.8'"

# Test that settings.xml is configured
check "settings-configured" bash -c "test -f ~/.m2/settings.xml"

reportResults
