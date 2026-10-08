#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults (location content, article/page view modes {full}).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sharethis.settings")
    ->set("location","content")
    ->set("sharethisnodes.article", ["full" => "full"])
    ->set("sharethisnodes.page", ["full" => "full"])
    ->save();
' >/dev/null 2>&1
echo "cleanup: sharethis.settings restored (location content, article/page {full})"
