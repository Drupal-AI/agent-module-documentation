#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\field_inheritance\Entity\FieldInheritance; if ($e = FieldInheritance::load("node_page_fi_strat")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node_page_fi_strat removed"
