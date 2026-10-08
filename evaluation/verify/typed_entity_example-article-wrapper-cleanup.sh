#!/usr/bin/env bash
# Introspection CLEANUP: uninstall typed_entity_example (baseline: disabled). Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu typed_entity_example -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: typed_entity_example uninstalled"
