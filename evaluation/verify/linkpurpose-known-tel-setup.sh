#!/usr/bin/env bash
# Introspection SETUP: disable the tel: link purpose so the agent can identify which link category is not being marked. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("linkpurpose.settings")->set("purposeTel", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: linkpurpose.settings purposeTel=false"
