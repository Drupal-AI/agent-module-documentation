#!/usr/bin/env bash
# Introspection CLEANUP: delete roles bpp_alpha and bpp_beta. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; foreach (["bpp_alpha","bpp_beta"] as $id) { if ($r = Role::load($id)) { $r->delete(); } }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: roles bpp_alpha, bpp_beta removed"
