#!/bin/bash

set -e

# Import test library
source dev-container-features-test-lib

echo "Testing installation in both user and system locations..."

# Test that settings.xml exists in user location
check "settings-xml-user" bash -c "test -f ~/.m2/settings.xml"

# Test that settings.xml exists in system location
check "settings-xml-system" bash -c "test -f /etc/maven/settings.xml"

# Test that both contain Jenkins repository
check "user-jenkins-repo" bash -c "grep -q 'repo.jenkins-ci.org' ~/.m2/settings.xml"
check "system-jenkins-repo" bash -c "grep -q 'repo.jenkins-ci.org' /etc/maven/settings.xml"

# Test that both files are identical
check "files-identical" bash -c "diff ~/.m2/settings.xml /etc/maven/settings.xml"

reportResults
