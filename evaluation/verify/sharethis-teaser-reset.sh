#!/usr/bin/env bash
# Execution RESET: set location=content and article view modes to just {full} (shipped default),
# so the verify (which requires location=links AND the article teaser enabled) FAILS. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sharethis.settings")
    ->set("location","content")
    ->set("sharethisnodes.article", ["full" => "full"])
    ->set("sharethisnodes.page", ["full" => "full"])
    ->save();
' >/dev/null 2>&1
echo "reset: sharethis location=content, sharethisnodes.article={full}"
