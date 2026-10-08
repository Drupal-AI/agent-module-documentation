#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped hcaptcha.settings widget defaults (theme='', max_score=0.8).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("hcaptcha.settings");
  $c->set("widget.theme", "")->set("widget.max_score", 0.8)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: hcaptcha.settings widget.theme='' widget.max_score=0.8 (baseline)"
