#!/usr/bin/env bash
# Execution RESET: make sure system.site has NO configuration override in place — uninstall
# and delete any custom override-provider module left from a previous attempt (the fixture
# name used by this case is cow_eval_task). After this, config_override_warn has nothing to
# report on the Basic site settings form, so verify FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu cow_eval_task -y >/dev/null 2>&1
rm -rf web/modules/custom/cow_eval_task
drush cr >/dev/null 2>&1
drush php:eval 'print "hasOverrides=" . var_export(\Drupal::config("system.site")->hasOverrides(), TRUE) . "\n";' 2>/dev/null
echo "reset: no override provider for system.site"
