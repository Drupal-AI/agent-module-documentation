#!/usr/bin/env bash
# Introspection CLEANUP: remove the bibcite_entity.mapping.bibtex config written by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("bibcite_entity.mapping.bibtex")->delete();' >/dev/null 2>&1 || true
echo "cleanup: bibcite_entity.mapping.bibtex removed"
