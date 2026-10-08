#!/usr/bin/env bash
# Introspection CLEANUP: delete the bibcite_known_type reference type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\bibcite_entity\Entity\ReferenceType;
  if ($t = ReferenceType::load("bibcite_known_type")) { $t->delete(); }
' >/dev/null 2>&1 || true
echo "cleanup: bibcite_reference_type bibcite_known_type removed"
