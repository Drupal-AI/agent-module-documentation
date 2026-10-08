#!/usr/bin/env bash
# Introspection CLEANUP: delete the rtf_known text format created by setup. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("rtf_known")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: format rtf_known removed"
