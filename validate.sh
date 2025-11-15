#!/bin/bash
set -e

echo "=========================================="
echo "Validating Dev Container Feature"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

validate() {
    if eval "$2" > /dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $1"
        return 0
    else
        echo -e "${RED}✗${NC} $1"
        return 1
    fi
}

# Validate JSON files
echo "Validating JSON files..."
validate "devcontainer-feature.json" "python3 -m json.tool src/jenkins-plugin-dev/devcontainer-feature.json"
validate "scenarios.json" "python3 -m json.tool test/jenkins-plugin-dev/scenarios.json"
echo ""

# Validate shell scripts
echo "Validating shell scripts..."
validate "install.sh syntax" "bash -n src/jenkins-plugin-dev/install.sh"
for test in test/jenkins-plugin-dev/*.sh; do
    validate "$(basename $test) syntax" "bash -n $test"
done
echo ""

# Check required files
echo "Checking required files..."
validate "devcontainer-feature.json exists" "test -f src/jenkins-plugin-dev/devcontainer-feature.json"
validate "install.sh exists" "test -f src/jenkins-plugin-dev/install.sh"
validate "install.sh is executable" "test -x src/jenkins-plugin-dev/install.sh"

validate "test.sh exists" "test -f test/jenkins-plugin-dev/test.sh"
validate "scenarios.json exists" "test -f test/jenkins-plugin-dev/scenarios.json"
validate "LICENSE exists" "test -f LICENSE"
validate "README.md exists" "test -f README.md"
echo ""

# Check GitHub Actions
echo "Checking GitHub Actions..."
validate "test.yaml exists" "test -f .github/workflows/test.yaml"
validate "release.yaml exists" "test -f .github/workflows/release.yaml"
echo ""

# Validate feature metadata
echo "Validating feature metadata..."
validate "Feature has id" "grep -q '\"id\": \"jenkins-plugin-dev\"' src/jenkins-plugin-dev/devcontainer-feature.json"
validate "Feature has version" "grep -q '\"version\"' src/jenkins-plugin-dev/devcontainer-feature.json"
validate "Feature has name" "grep -q '\"name\"' src/jenkins-plugin-dev/devcontainer-feature.json"
validate "Feature has description" "grep -q '\"description\"' src/jenkins-plugin-dev/devcontainer-feature.json"
echo ""

# Count test scenarios
SCENARIO_COUNT=$(python3 -c "import json; print(len(json.load(open('test/jenkins-plugin-dev/scenarios.json'))))")
echo "Test scenarios: ${SCENARIO_COUNT}"
echo ""

echo "=========================================="
echo "Validation Complete!"
echo "=========================================="
