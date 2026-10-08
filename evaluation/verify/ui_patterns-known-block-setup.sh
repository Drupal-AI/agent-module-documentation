#!/usr/bin/env bash
# introspection setup: place a UI Patterns component block in Olivero with a known
# component id and a known static slot value, so the agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($b = \Drupal\block\Entity\Block::load("uipeval_known_teaser")) { $b->delete(); }
  \Drupal\block\Entity\Block::create([
    "id" => "uipeval_known_teaser", "theme" => "olivero", "region" => "content",
    "plugin" => "ui_patterns:olivero:teaser",
    "settings" => [
      "id" => "ui_patterns:olivero:teaser", "label" => "Known Teaser", "label_display" => "0",
      "ui_patterns" => [
        "component_id" => "olivero:teaser", "variant_id" => "", "props" => [],
        "slots" => ["title" => ["sources" => [[
          "source_id" => "textfield", "source" => ["value" => "UI Patterns Eval Title"],
          "value" => "UI Patterns Eval Title"]]]],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block uipeval_known_teaser renders ui_patterns:olivero:teaser (title='UI Patterns Eval Title')"
