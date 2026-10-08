#!/usr/bin/env bash
# CLEANUP/RESET: delete the layout_paragraphs_limit.settings config object to restore the
# module's pristine (no-rules) baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("layout_paragraphs_limit.settings")->delete();' >/dev/null 2>&1
echo "cleanup: layout_paragraphs_limit.settings removed (baseline)"
