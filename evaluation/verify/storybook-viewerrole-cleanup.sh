#!/usr/bin/env bash
# Introspection CLEANUP: delete the storybook_viewer role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if ($r=Role::load("storybook_viewer")) { $r->delete(); }' >/dev/null 2>&1
echo "cleanup: storybook_viewer role removed"
