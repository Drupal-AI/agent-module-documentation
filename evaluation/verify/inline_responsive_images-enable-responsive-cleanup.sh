#!/usr/bin/env bash
# Execution CLEANUP: delete the iri_rtask text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($ff=\Drupal\filter\Entity\FilterFormat::load("iri_rtask")) { $ff->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: format iri_rtask removed"
