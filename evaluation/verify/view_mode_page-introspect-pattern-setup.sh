#!/usr/bin/env bash
# Introspection SETUP: create view_mode_page pattern vmp_alt (full at /%/vmp-detail). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("view_mode_page_pattern");
  if (!$s->load("vmp_alt")) {
    $s->create([
      "id" => "vmp_alt", "label" => "VMP Alt",
      "type" => "canonical_entities:node", "pattern" => "/%/vmp-detail",
      "view_mode" => "full", "selection_criteria" => [], "selection_logic" => "and", "weight" => 0,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view_mode_page.pattern.vmp_alt (view_mode=full pattern=/%/vmp-detail)"
