#!/bin/bash

set -e

# Import test library
source dev-container-features-test-lib

echo "Testing full custom configuration..."

# Test that Maven is installed
check "maven-installed" bash -c "mvn --version"

# Test that settings.xml exists in both locations
check "settings-user-exists" bash -c "test -f ~/.m2/settings.xml"
check "settings-system-exists" bash -c "test -f /etc/maven/settings.xml"

# Test that incremental build is enabled
check "incremental-enabled" bash -c "grep -q 'jenkins-incremental' ~/.m2/settings.xml"
check "incrementals-repo-configured" bash -c "grep -q 'repo.jenkins-ci.org/incrementals' ~/.m2/settings.xml"

# Test that additional profiles are configured
check "additional-profiles-configured" bash -c "grep -q 'development' ~/.m2/settings.xml && grep -q 'fast-build' ~/.m2/settings.xml"

# Test that both profiles are active
check "profiles-active" bash -c "grep -A 10 '<activeProfiles>' ~/.m2/settings.xml | grep -q 'development' && grep -A 10 '<activeProfiles>' ~/.m2/settings.xml | grep -q 'fast-build'"

reportResults
