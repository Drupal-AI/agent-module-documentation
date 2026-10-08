#!/usr/bin/env bash
# Introspection CLEANUP: remove the mfx_a and mfx_b vocabularies. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  foreach (["mfx_a","mfx_b"] as $vid) { if ($v = Vocabulary::load($vid)) { $v->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mfx_a and mfx_b removed"
