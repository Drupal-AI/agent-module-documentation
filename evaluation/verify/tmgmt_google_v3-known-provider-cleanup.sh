#!/usr/bin/env bash
# Introspection CLEANUP: delete the tmgmtg_probe translator created by the matching setup.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  if ($t = Translator::load("tmgmtg_probe")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tmgmt.translator.tmgmtg_probe removed"
