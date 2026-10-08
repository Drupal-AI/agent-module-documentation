#!/usr/bin/env bash
# Execution CLEANUP: delete the sf_task Swiper template. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\swiper_formatter\Entity\SwiperFormatter;
  if ($e = SwiperFormatter::load("sf_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sf_task removed"
