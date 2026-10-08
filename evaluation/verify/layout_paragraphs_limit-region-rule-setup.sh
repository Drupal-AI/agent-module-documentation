#!/usr/bin/env bash
# Introspection SETUP: configure layout_paragraphs_limit to EXCLUDE paragraph type bp_card
# from the "content" region of the layout_onecol layout. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("layout_paragraphs_limit.settings");
  $c->set("disallowed_types.layout_onecol.content", [
    "negate" => FALSE, "numeric_limit" => 0,
    "paragraph_types" => ["bp_card" => "bp_card"],
  ])->save();
' >/dev/null 2>&1
echo "setup: layout_onecol/content excludes bp_card (negate=false)"
