#!/usr/bin/env bash
# Introspection CLEANUP: delete the cs_eval2.module.cs_eval2mod snapshot entity. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = Drupal\config_snapshot\Entity\ConfigSnapshot::load("cs_eval2.module.cs_eval2mod")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: config snapshot cs_eval2.module.cs_eval2mod removed"
