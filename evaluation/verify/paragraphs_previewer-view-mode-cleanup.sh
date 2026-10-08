#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default previewer view mode (full). Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("paragraphs_previewer.settings")
    ->set("previewer_view_mode", "full")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: paragraphs_previewer.settings previewer_view_mode restored to full"
