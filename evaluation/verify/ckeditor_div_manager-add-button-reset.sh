#!/usr/bin/env bash
# Execution RESET: (re)create a CKEditor 5 text format cdm_task whose toolbar does NOT
# include the Div Manager button, so verify FAILS until the agent adds it. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("cdm_task")) {
    FilterFormat::create(["format" => "cdm_task", "name" => "CDM Task", "filters" => []])->save();
  }
  $e = Editor::load("cdm_task");
  if (!$e) {
    $e = Editor::create(["format" => "cdm_task", "editor" => "ckeditor5", "settings" => []]);
  }
  $e->setSettings(["toolbar" => ["items" => ["bold","italic"]], "plugins" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cdm_task exists (ckeditor5) with toolbar bold,italic and NO DivManager"
