#!/usr/bin/env bash
# Execution RESET: remove every openid_connect_client config entity that uses the
# windows_aad plugin so the verify starts from empty state (no such client ships by
# default, so this only clears eval artifacts). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("openid_connect_client")->loadMultiple() as $c) {
    if ($c->getPluginId() === "windows_aad") { $c->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: all windows_aad openid_connect_client entities removed"
