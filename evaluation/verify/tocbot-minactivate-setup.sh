#!/usr/bin/env bash
# Introspection SETUP (tocbot): set tocbot.settings min_activate to a known distinctive value (7)
# so an inspecting agent can read back the minimum heading count before the TOC activates.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tocbot.settings")->set("min_activate", "7")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tocbot.settings min_activate = 7"
