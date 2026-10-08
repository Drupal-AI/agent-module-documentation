#!/usr/bin/env bash
# Execution RESET (hard): disable theme development mode so verify FAILs on empty state. The
# agent must enable it using drupal_cms_helper's themeDevelopmentMode action. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("plugin.manager.config_action")
    ->applyAction("themeDevelopmentMode", "system.theme", FALSE);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: theme development mode disabled (twig_debug cleared)"
