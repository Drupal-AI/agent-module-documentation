#!/usr/bin/env bash
# Introspection CLEANUP: delete so_on and so_off.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\paragraphs\Entity\ParagraphsType; foreach(["so_on","so_off"] as $id){ if ($pt = ParagraphsType::load($id)) { $pt->delete(); } }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: so_on and so_off removed"
