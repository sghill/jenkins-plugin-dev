#!/bin/bash

set -e

# Import test library
source dev-container-features-test-lib

echo "Testing Maven 3.9 installation..."

# Test that Maven is installed
check "maven-installed" bash -c "mvn --version"

# Test that Maven version is 3.9.x
check "maven-version-3-9" bash -c "mvn --version | grep -q 'Apache Maven 3.9'"

# Test that settings.xml is configured
check "settings-configured" bash -c "test -f ~/.m2/settings.xml"

reportResults
