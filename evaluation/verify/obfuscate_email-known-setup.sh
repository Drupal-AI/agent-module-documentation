#!/usr/bin/env bash
# Introspection SETUP: create text format oe_test_format with the obfuscate_email filter enabled
# and a known click_label, so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("oe_test_format") ?: FilterFormat::create(["format" => "oe_test_format", "name" => "OE Test Format"]);
  $f->setFilterConfig("obfuscate_email", [
    "status" => TRUE,
    "settings" => ["click" => TRUE, "click_label" => "OE_CLICK_SENTINEL"],
  ]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: oe_test_format has obfuscate_email enabled (click_label=OE_CLICK_SENTINEL)"
