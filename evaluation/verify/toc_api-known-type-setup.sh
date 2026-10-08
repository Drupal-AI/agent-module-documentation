#!/usr/bin/env bash
# Introspection SETUP: create a toc_type config entity toc_api_eval1 with a distinctive
# template (menu) and title, so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\toc_api\Entity\TocType;
  if (!TocType::load("toc_api_eval1")) {
    TocType::create([
      "id" => "toc_api_eval1", "label" => "Eval Sidebar Menu",
      "options" => [
        "template" => "menu", "title" => "On this eval page",
        "header_min" => 2, "header_max" => 3, "header_count" => 2,
        "default" => ["number_type" => "decimal", "number_prefix" => "", "number_suffix" => ") "],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: toc_api.toc_type.toc_api_eval1 created (template=menu)"
