#!/bin/bash

set -e

# Import test library
source dev-container-features-test-lib

echo "Testing default configuration..."

# Same as main test.sh - verify default behavior
check "settings-xml-exists" bash -c "test -f ~/.m2/settings.xml"
check "jenkins-repo-configured" bash -c "grep -q 'repo.jenkins-ci.org' ~/.m2/settings.xml"
check "no-incremental-by-default" bash -c "! grep -q 'jenkins-incremental' ~/.m2/settings.xml"

reportResults
