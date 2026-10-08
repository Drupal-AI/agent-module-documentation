#!/usr/bin/env bash
# Introspection CLEANUP: delete the vbpefd_view View. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View; if($v=View::load("vbpefd_view")){$v->delete();}' >/dev/null 2>&1
echo "cleanup: vbpefd_view removed"
