#!/usr/bin/env bash
# Execution RESET: ensure the eval test module (anonymizer_eval) and its plugin are ABSENT so
# verify FAILS until the agent adds a custom anonymizer. Uninstalls the module BEFORE removing
# its directory (an orphaned enabled module fatals the kernel). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx anonymizer_eval; then
  drush pmu anonymizer_eval -y >/dev/null 2>&1 || true
fi
rm -rf web/modules/custom/anonymizer_eval 2>/dev/null || true
drush php:eval '\Drupal::service("plugin.manager.anonymizer")->clearCachedDefinitions();' >/dev/null 2>&1 || true
echo "reset: anonymizer_eval module + anonymizer_eval_static plugin absent"
