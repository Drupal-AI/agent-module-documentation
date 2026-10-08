#!/usr/bin/env bash
# Introspection SETUP: create a simple config object config_delete_known.settings with a known
# marker value so an agent can read it back (finding config is a prerequisite to deleting it).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_delete_known.settings")
    ->set("marker", "CD_EVAL_MARKER_42")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: config_delete_known.settings marker=CD_EVAL_MARKER_42"
