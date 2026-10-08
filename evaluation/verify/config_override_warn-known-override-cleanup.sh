#!/usr/bin/env bash
# Introspection CLEANUP: uninstall and delete the cow_eval_override fixture module, so
# system.site has no overrides again. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu cow_eval_override -y >/dev/null 2>&1
rm -rf web/modules/custom/cow_eval_override
drush cr >/dev/null 2>&1
drush php:eval 'print "hasOverrides=" . var_export(\Drupal::config("system.site")->hasOverrides(), TRUE) . "\n";' 2>/dev/null
echo "cleanup: cow_eval_override removed"
