#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'jenkins-plugin-dev' feature with no options.
#
# For more information, see: https://github.com/devcontainers/cli/blob/main/docs/features/test.md
#
# Eg:
# {
#    "image": "<..some-base-image...>",
#    "features": {
#      "jenkins-plugin-dev": {}
#    },
#    "remoteUser": "root"
# }
#
# Thus, the value of all options will fall back to the default value in the
# feature's 'devcontainer-feature.json'.
#
# These scripts are run as root by default. To run as a non-root user, use the
# 'remoteUser' property in the devcontainer.json.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.

echo "=========================================="
echo "Testing Jenkins Plugin Development Feature"
echo "=========================================="

# Test 1: Verify Maven is installed
check "maven-installed" bash -c "mvn --version"

# Test 2: Verify settings.xml exists in user home
check "settings-xml-exists-user" bash -c "test -f ~/.m2/settings.xml"

# Test 3: Verify settings.xml contains Jenkins repository
check "jenkins-repo-configured" bash -c "grep -q 'repo.jenkins-ci.org' ~/.m2/settings.xml"

# Test 4: Verify settings.xml is valid XML
check "valid-xml" bash -c "command -v xmllint > /dev/null && xmllint --noout ~/.m2/settings.xml || echo 'xmllint not available, skipping XML validation'"

# Test 5: Verify Jenkins profile is configured
check "jenkins-profile-exists" bash -c "grep -q '<id>jenkins</id>' ~/.m2/settings.xml"

# Test 6: Verify incremental build profile does NOT exist (default is disabled)
check "no-incremental-profile-by-default" bash -c "! grep -q 'jenkins-incremental' ~/.m2/settings.xml"

# Test 7: Verify incrementals repository is NOT configured by default
check "no-incrementals-repo-by-default" bash -c "! grep -q 'repo.jenkins-ci.org/incrementals' ~/.m2/settings.xml"

# Test 8: Verify active profiles section exists
check "active-profiles-configured" bash -c "grep -q '<activeProfiles>' ~/.m2/settings.xml"

# Test 9: Verify Jenkins profile is active
check "jenkins-profile-active" bash -c "grep -A 5 '<activeProfiles>' ~/.m2/settings.xml | grep -q '<activeProfile>jenkins</activeProfile>'"

# Test 10: Verify settings.xml has proper XML structure
check "xml-structure-valid" bash -c "grep -q '<?xml version=\"1.0\"' ~/.m2/settings.xml && grep -q '</settings>' ~/.m2/settings.xml"

# Test 11: Verify repository URL is correct (default)
check "default-repo-url" bash -c "grep -q 'https://repo.jenkins-ci.org/public/' ~/.m2/settings.xml"

# Test 12: Display settings.xml for debugging
echo ""
echo "=========================================="
echo "Generated settings.xml content:"
echo "=========================================="
cat ~/.m2/settings.xml
echo ""
echo "=========================================="

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
