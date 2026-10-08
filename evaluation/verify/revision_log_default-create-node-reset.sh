#!/usr/bin/env bash
# Execution RESET: remove any node titled 'RLD Hard Created' so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "RLD Hard Created"]) as $e) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no node titled 'RLD Hard Created'"
