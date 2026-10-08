#!/usr/bin/env bash
# Execution RESET: set fitvids.settings selectors to the shipped default (.node) so verify
# FAILS until the agent points FitVids at the .content selector. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("fitvids.settings")->set("selectors", ".node")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: fitvids.settings selectors = .node"
