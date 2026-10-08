#!/usr/bin/env bash
# Introspection CLEANUP: delete the iri_eval text format created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($ff=\Drupal\filter\Entity\FilterFormat::load("iri_eval")) { $ff->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: format iri_eval removed"
