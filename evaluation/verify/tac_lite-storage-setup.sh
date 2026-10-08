#!/usr/bin/env bash
# Introspection SETUP: set tac_lite term identifier storage to 'uuid' so an inspecting agent
# can read it back. Config-only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("tac_lite.settings")->set("tac_lite_storage_type", "uuid")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tac_lite.settings tac_lite_storage_type=uuid"
