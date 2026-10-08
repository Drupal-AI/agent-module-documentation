#!/usr/bin/env bash
# Introspection CLEANUP: remove the mfx_evt vocabulary created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  if ($v = Vocabulary::load("mfx_evt")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vocabulary mfx_evt removed"
