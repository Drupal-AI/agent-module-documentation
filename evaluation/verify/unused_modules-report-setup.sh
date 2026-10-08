#!/usr/bin/env bash
# Introspection SETUP: ensure a disabled fixture module um_fixture (its own project) exists on disk
# so unused_modules reports it as unused/safe-to-delete and an agent can read it back. It is NEVER
# enabled. Idempotent.
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
echo "setup: web/modules/custom/um_fixture present (disabled) -> reported as unused"
