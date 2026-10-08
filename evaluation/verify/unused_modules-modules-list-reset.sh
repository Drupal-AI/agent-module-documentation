#!/usr/bin/env bash
# Execution RESET: ensure the disabled um_fixture module exists on disk and delete any prior report
# at public://um_report.txt, so verify FAILS until the agent produces the report. Idempotent.
set -uo pipefail
cd /var/www/html

FX=web/modules/custom/um_fixture
mkdir -p "$FX"
cat > "$FX/um_fixture.info.yml" <<INFO
name: "UM Fixture (unused_modules eval)"
type: module
description: "Eval fixture for unused_modules: an intentionally DISABLED module on disk with its own project, reported as unused/safe-to-delete. Never enable it."
core_version_requirement: ^10 || ^11
package: Testing
project: "um_fixture"
version: "1.0.0"
INFO
rm -f web/sites/default/files/um_report.txt
echo "reset: um_fixture present; public://um_report.txt removed"
