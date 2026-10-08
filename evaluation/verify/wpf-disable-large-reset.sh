#!/usr/bin/env bash
# Execution RESET: clear wpf.settings styles.disabled so verify FAILS until the agent disables the
# 'large' image style's fallback. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("wpf.settings")->set("styles.disabled", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: wpf.settings styles.disabled=[] (default)"
