#!/bin/bash

set -e

# Import test library
source dev-container-features-test-lib

echo "Testing custom repository configuration..."

# Test custom repository URL is configured
check "custom-repo-url" bash -c "grep -q 'https://custom.jenkins.repo/maven' ~/.m2/settings.xml"

# Test custom mirror ID is configured
check "custom-mirror-id" bash -c "grep -q '<id>custom-jenkins</id>' ~/.m2/settings.xml"

# Test that default repo is NOT present
check "no-default-repo" bash -c "! grep -q 'https://repo.jenkins-ci.org/public/' ~/.m2/settings.xml"

reportResults
