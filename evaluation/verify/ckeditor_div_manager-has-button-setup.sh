#!/usr/bin/env bash
# Introspection SETUP: create a CKEditor 5 text format cdm_known whose toolbar includes the
# Div Manager button, so an inspecting agent can read the enabled toolbar item id.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("cdm_known")) {
    FilterFormat::create(["format" => "cdm_known", "name" => "CDM Known", "filters" => []])->save();
  }
  if (!Editor::load("cdm_known")) {
    Editor::create(["format" => "cdm_known", "editor" => "ckeditor5",
      "settings" => ["toolbar" => ["items" => ["heading","bold","DivManager","link"]], "plugins" => []]])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cdm_known toolbar = heading,bold,DivManager,link"
