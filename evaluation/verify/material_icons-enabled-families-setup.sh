#!/usr/bin/env bash
# Introspection SETUP: enable a known set of Material Icons families (baseline + two-tone) so an
# inspecting agent can list them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("material_icons.settings")->set("families", ["baseline", "two-tone"])->save();' >/dev/null 2>&1
echo "setup: material_icons.settings families=[baseline, two-tone]"
