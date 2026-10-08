#!/usr/bin/env bash
# Introspection CLEANUP: delete the ckme_probe_format text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("ckme_probe_format")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckme_probe_format removed"
