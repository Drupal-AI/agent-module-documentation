#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults (A-Z / 0-9 / #). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("search_api_glossary.settings")->set("group_prefix", ["alpha" => "A-Z", "numeric" => "0-9", "special" => "#"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: search_api_glossary.settings group_prefix restored"
