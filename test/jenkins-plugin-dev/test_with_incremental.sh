#!/bin/bash

set -e

# Import test library
source dev-container-features-test-lib

echo "Testing with incremental builds enabled..."

# Test that incremental profile exists
check "incremental-profile-exists" bash -c "grep -q 'jenkins-incremental' ~/.m2/settings.xml"

# Test that incrementals repository is configured
check "incrementals-repo-configured" bash -c "grep -q 'repo.jenkins-ci.org/incrementals' ~/.m2/settings.xml"

# Test that main Jenkins profile still exists
check "jenkins-profile-exists" bash -c "grep -q '<id>jenkins</id>' ~/.m2/settings.xml"

# Test that incremental profile is active
check "incremental-profile-active" bash -c "grep -A 10 '<activeProfiles>' ~/.m2/settings.xml | grep -q '<activeProfile>jenkins-incremental</activeProfile>'"

reportResults
