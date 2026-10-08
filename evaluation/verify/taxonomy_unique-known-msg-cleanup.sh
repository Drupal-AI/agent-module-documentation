#!/usr/bin/env bash
# Introspection CLEANUP: delete vocabulary tu_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\taxonomy\Entity\Vocabulary; if($v=Vocabulary::load("tu_known")){$v->delete();}' >/dev/null 2>&1
echo "cleanup: vocabulary tu_known removed"
