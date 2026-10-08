#!/usr/bin/env bash
# Introspection CLEANUP: delete roles mtr_a and mtr_b. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; foreach(["mtr_a","mtr_b"] as $id){ if($r=Role::load($id)){$r->delete();} }' >/dev/null 2>&1
echo "cleanup: roles mtr_a, mtr_b removed"
