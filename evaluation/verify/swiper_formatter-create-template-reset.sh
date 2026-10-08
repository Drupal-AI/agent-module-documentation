#!/usr/bin/env bash
# Execution RESET: delete the sf_task Swiper template so the agent must create it. Verify
# FAILS on this empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\swiper_formatter\Entity\SwiperFormatter;
  if ($e = SwiperFormatter::load("sf_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: swiper template sf_task absent"
