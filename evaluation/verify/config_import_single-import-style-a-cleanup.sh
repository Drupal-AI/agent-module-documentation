#!/usr/bin/env bash
# Execution CLEANUP: remove image style cis_hard_a and the temp file. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("cis_hard_a")) { $s->delete(); }
' >/dev/null 2>&1
rm -f /tmp/image.style.cis_hard_a.yml
drush cr >/dev/null 2>&1
echo "cleanup: image style cis_hard_a and temp file removed"
