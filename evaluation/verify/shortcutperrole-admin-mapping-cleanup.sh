#!/usr/bin/env bash
# Introspection CLEANUP (shortcutperrole): remove administrator and content_editor mappings. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c=\Drupal::configFactory()->getEditable("shortcutperrole.settings");
  $c->clear("role.administrator")->clear("role.content_editor")->save();
' >/dev/null 2>&1 || true
echo "cleanup: administrator and content_editor mappings removed"
exit 0
