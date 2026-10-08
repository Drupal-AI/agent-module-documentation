#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\system\Entity\Action; if ($a = Action::load("bibcite_export_vbo_known")) { $a->delete(); }' >/dev/null 2>&1 || true
echo "cleanup: action bibcite_export_vbo_known removed"
