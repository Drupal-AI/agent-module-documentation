#!/usr/bin/env bash
# Introspection SETUP: ensure micon_ckeditor is enabled and the fa Micon package is active, so an
# agent can read back which package's CSS is injected into CKEditor. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install micon_ckeditor -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "setup: micon_ckeditor enabled; active packages = $(drush php:eval 'print implode(",", array_keys(\Drupal\micon\Entity\Micon::loadActiveLabels()));' 2>/dev/null)"
