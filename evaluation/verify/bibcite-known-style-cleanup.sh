#!/usr/bin/env bash
# Introspection CLEANUP: delete the bibcite_known_style CSL style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\bibcite\Entity\CslStyle;
  if ($s = CslStyle::load("bibcite_known_style")) { $s->delete(); }
' >/dev/null 2>&1 || true
echo "cleanup: bibcite_csl_style bibcite_known_style removed"
