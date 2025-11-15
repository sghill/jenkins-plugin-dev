#!/bin/bash

set -e

# Import test library
source dev-container-features-test-lib

echo "Testing offline mode configuration..."

# Test that offline mode is enabled in settings.xml
check "offline-mode-enabled" bash -c "grep -q '<offline>true</offline>' ~/.m2/settings.xml"

# Test that Jenkins repository is still configured (for when going online)
check "jenkins-repo-still-configured" bash -c "grep -q 'repo.jenkins-ci.org' ~/.m2/settings.xml"

reportResults
