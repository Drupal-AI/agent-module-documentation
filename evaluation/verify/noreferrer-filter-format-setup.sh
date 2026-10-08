#!/usr/bin/env bash
# Introspection SETUP: create a text format nrf_known with the noreferrer filter enabled, so an
# agent can discover which format applies the No Referrer attributes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("nrf_known");
  if (!$f) {
    $f = FilterFormat::create(["format" => "nrf_known", "name" => "NRF Known"]);
  }
  $f->setFilterConfig("noreferrer", ["status" => TRUE, "weight" => 10]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format nrf_known has the noreferrer filter enabled"
