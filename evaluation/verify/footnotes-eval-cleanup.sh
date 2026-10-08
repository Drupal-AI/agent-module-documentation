#!/usr/bin/env bash
# CLEANUP (shared): delete the namespaced footnotes_eval text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f = FilterFormat::load("footnotes_eval")) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: footnotes_eval format removed"
