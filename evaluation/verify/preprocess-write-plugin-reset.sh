#!/usr/bin/env bash
# Execution RESET: create + enable a scaffold host module (preprocess_task_host) that has a
# Plugin/Preprocess namespace but NO preprocess plugin yet, so verify FAILS until the agent
# writes one for the 'page' hook. Removes any plugin left from a previous attempt WITHOUT
# deleting the whole directory while enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
D=web/modules/custom/preprocess_task_host
mkdir -p "$D/src/Plugin/Preprocess"
cat > "$D/preprocess_task_host.info.yml" <<'YML'
name: 'Preprocess Task Host'
type: module
core_version_requirement: ^10 || ^11
dependencies:
  - preprocess:preprocess
YML
# Strip any previously-added plugin registrations / classes.
rm -f "$D"/*.preprocessors.yml
rm -f "$D"/src/Plugin/Preprocess/*.php
drush en preprocess_task_host -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: module preprocess_task_host enabled with NO preprocess plugin"
