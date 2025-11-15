#!/bin/bash

set -e

# Import test library
source dev-container-features-test-lib

echo "Testing with additional profiles..."

# Test that additional profiles are configured
check "release-profile-active" bash -c "grep -A 10 '<activeProfiles>' ~/.m2/settings.xml | grep -q '<activeProfile>release</activeProfile>'"

check "sign-artifacts-profile-active" bash -c "grep -A 10 '<activeProfiles>' ~/.m2/settings.xml | grep -q '<activeProfile>sign-artifacts</activeProfile>'"

# Test that default profiles still exist
check "jenkins-profile-still-active" bash -c "grep -A 10 '<activeProfiles>' ~/.m2/settings.xml | grep -q '<activeProfile>jenkins</activeProfile>'"

reportResults
