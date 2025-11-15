#!/bin/bash

set -e

# Import test library
source dev-container-features-test-lib

echo "Testing system-wide installation..."

# Test that settings.xml exists in system location
check "settings-xml-system" bash -c "test -f /etc/maven/settings.xml"

# Test that system settings.xml contains Jenkins repository
check "system-jenkins-repo" bash -c "grep -q 'repo.jenkins-ci.org' /etc/maven/settings.xml"

# Test that user settings.xml does NOT exist (system only)
check "no-user-settings" bash -c "! test -f ~/.m2/settings.xml"

reportResults
