#!/usr/bin/env bash
# Introspection SETUP: create two CKEditor 5 text formats, cdm_on (with the Div Manager
# button) and cdm_off (without it), so an inspecting agent can tell which format enables
# ckeditor_div_manager. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  foreach (["cdm_on" => ["bold","italic","DivManager"], "cdm_off" => ["bold","italic"]] as $id => $items) {
    if (!FilterFormat::load($id)) {
      FilterFormat::create(["format" => $id, "name" => strtoupper($id), "filters" => []])->save();
    }
    if (!Editor::load($id)) {
      Editor::create(["format" => $id, "editor" => "ckeditor5",
        "settings" => ["toolbar" => ["items" => $items], "plugins" => []]])->save();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cdm_on has DivManager in toolbar; cdm_off does not"
