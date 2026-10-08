#!/usr/bin/env bash
# Execution RESET: create + enable a scaffold host module (preprocess_yaml_host) with a
# Plugin/Preprocess namespace but NO preprocess plugin, so verify FAILS until the agent
# registers one for the 'node' hook (via *.preprocessors.yml or annotation). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
D=web/modules/custom/preprocess_yaml_host
mkdir -p "$D/src/Plugin/Preprocess"
cat > "$D/preprocess_yaml_host.info.yml" <<'YML'
name: 'Preprocess Yaml Host'
type: module
core_version_requirement: ^10 || ^11
dependencies:
  - preprocess:preprocess
YML
rm -f "$D"/*.preprocessors.yml
rm -f "$D"/src/Plugin/Preprocess/*.php
drush en preprocess_yaml_host -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: module preprocess_yaml_host enabled with NO preprocess plugin"
