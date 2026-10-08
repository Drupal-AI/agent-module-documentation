#!/usr/bin/env bash
# Introspection CLEANUP: delete the fi_known inheritance created by setup. Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\field_inheritance\Entity\FieldInheritance; if ($e = FieldInheritance::load("node_page_fi_known")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field inheritance node_page_fi_known removed"
