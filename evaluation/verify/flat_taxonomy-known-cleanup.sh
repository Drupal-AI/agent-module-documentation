#!/usr/bin/env bash
# Introspection CLEANUP: delete the flattax_known vocabulary. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  if ($v = Vocabulary::load("flattax_known")) { $v->delete(); }
' >/dev/null 2>&1
echo "cleanup: vocabulary flattax_known removed"
