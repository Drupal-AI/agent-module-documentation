#!/usr/bin/env bash
# Execution CLEANUP: remove the mfx_lock vocabulary entirely. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  if ($v = Vocabulary::load("mfx_lock")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vocabulary mfx_lock removed"
