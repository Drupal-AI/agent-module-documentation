#!/usr/bin/env bash
# Introspection SETUP: create view_mode_page pattern vmp_known (teaser at /%/vmp-summary) so an
# agent can read its view_mode/pattern back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("view_mode_page_pattern");
  if (!$s->load("vmp_known")) {
    $s->create([
      "id" => "vmp_known", "label" => "VMP Known",
      "type" => "canonical_entities:node", "pattern" => "/%/vmp-summary",
      "view_mode" => "teaser", "selection_criteria" => [], "selection_logic" => "and", "weight" => 0,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view_mode_page.pattern.vmp_known (view_mode=teaser pattern=/%/vmp-summary)"
