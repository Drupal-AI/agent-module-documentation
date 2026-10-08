#!/usr/bin/env bash
# Introspection SETUP: set a numeric component limit of 2 on the "first" region of the
# layout_twocol layout. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("layout_paragraphs_limit.settings");
  $c->set("disallowed_types.layout_twocol.first", [
    "negate" => FALSE, "numeric_limit" => 2, "paragraph_types" => [],
  ])->save();
' >/dev/null 2>&1
echo "setup: layout_twocol/first numeric_limit=2"
