#!/usr/bin/env bash
# Execution RESET: force shipped default group_prefix so verify FAILS until the agent localises it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("search_api_glossary.settings")->set("group_prefix", ["alpha" => "A-Z", "numeric" => "0-9", "special" => "#"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: search_api_glossary.settings group_prefix = defaults"
