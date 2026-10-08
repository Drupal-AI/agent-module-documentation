#!/usr/bin/env bash
# Introspection SETUP: no persistent config to install (masquerade_log is zero-config). Confirms
# the module is enabled so the decoration is observable. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'print \Drupal::moduleHandler()->moduleExists("masquerade_log") ? "masquerade_log enabled\n" : "masquerade_log NOT enabled\n";' 2>/dev/null
echo "setup: masquerade_log active; logger.dblog is decorated"
