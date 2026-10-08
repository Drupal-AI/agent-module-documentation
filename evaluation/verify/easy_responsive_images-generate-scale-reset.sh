#!/usr/bin/env bash
# Execution RESET: delete responsive_300w/600w/900w so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  foreach (["responsive_300w","responsive_600w","responsive_900w"] as $n) { if ($s = ImageStyle::load($n)) { $s->delete(); } }
' >/dev/null 2>&1
echo "reset: responsive_300w/600w/900w removed"
