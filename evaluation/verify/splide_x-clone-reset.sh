#!/usr/bin/env bash
# Execution RESET: ensure optionset x_clone does NOT exist, so verify FAILS until the agent clones one of
# splide_x's example optionsets (x_carousel) into x_clone. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\splide\Entity\Splide; if ($e = Splide::load("x_clone")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: optionset x_clone absent"
