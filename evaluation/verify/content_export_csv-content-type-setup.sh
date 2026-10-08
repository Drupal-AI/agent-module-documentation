#!/usr/bin/env bash
# Introspection SETUP: create content type cecsv_survey so an agent can read back which content
# types the Content Export CSV form would list for export. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("cecsv_survey")) { NodeType::create(["type" => "cecsv_survey", "name" => "CECSV Survey"])->save(); }
' >/dev/null 2>&1
echo "setup: content type cecsv_survey present (exportable via content_export_csv)"
