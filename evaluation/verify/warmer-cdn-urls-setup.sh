#!/usr/bin/env bash
# Stage a known CDN-warmer config on the live site for the medium introspection case:
# warmer.settings:warmers.cdn warms https://example.com/warm-me and /about,
# frequency 600, batchSize 10.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("warmer.settings")
    ->set("warmers.cdn", [
      "id" => "cdn",
      "frequency" => 600,
      "batchSize" => 10,
      "urls" => ["https://example.com/warm-me", "/about"],
      "headers" => [],
      "verify" => TRUE,
      "maxConcurrentRequests" => 10,
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: warmer.settings warmers.cdn = urls[https://example.com/warm-me,/about], frequency 600"
