#!/usr/bin/env bash
# Introspection CLEANUP: restore the Default redirect to shipped baseline (code null = disabled,
# path '', mode translatable). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("content_translation_redirect.entity.default")
    ->set("code", NULL)->set("path", "")->set("mode", "translatable")->save();
' >/dev/null 2>&1
echo "cleanup: Default redirect restored (code null, mode translatable)"
