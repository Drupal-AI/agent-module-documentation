#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\context\Entity\Context; if ($e = Context::load("cadl_hard2")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: context cadl_hard2 removed"
