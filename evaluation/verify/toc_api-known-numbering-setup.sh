#!/usr/bin/env bash
# Introspection SETUP: create a toc_type toc_api_eval2 whose default numbering type is
# upper-roman, so an agent can read the numbering style back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\toc_api\Entity\TocType;
  if (!TocType::load("toc_api_eval2")) {
    TocType::create([
      "id" => "toc_api_eval2", "label" => "Eval Roman",
      "options" => [
        "template" => "tree", "title" => "Roman Contents",
        "header_min" => 2, "header_max" => 4, "header_count" => 2,
        "default" => ["number_type" => "upper-roman", "number_prefix" => "", "number_suffix" => ". "],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: toc_api.toc_type.toc_api_eval2 created (default.number_type=upper-roman)"
