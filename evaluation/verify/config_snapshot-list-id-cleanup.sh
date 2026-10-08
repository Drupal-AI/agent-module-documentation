#!/usr/bin/env bash
# Introspection CLEANUP: delete the cs_eval.module.cs_evalmod snapshot entity. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = Drupal\config_snapshot\Entity\ConfigSnapshot::load("cs_eval.module.cs_evalmod")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: config snapshot cs_eval.module.cs_evalmod removed"
