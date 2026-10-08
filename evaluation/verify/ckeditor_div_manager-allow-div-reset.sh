#!/usr/bin/env bash
# Execution RESET: (re)create a text format cdm_filter that has the Div Manager button in a
# CKEditor 5 toolbar AND filter_html enabled but whose allowed HTML does NOT permit <div>,
# so verify FAILS until the agent allows the <div> tag. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  $ff = FilterFormat::load("cdm_filter");
  if (!$ff) { $ff = FilterFormat::create(["format" => "cdm_filter", "name" => "CDM Filter"]); }
  $ff->set("filters", [
    "filter_html" => [
      "id" => "filter_html", "provider" => "filter", "status" => TRUE, "weight" => -10,
      "settings" => ["allowed_html" => "<p> <br> <strong> <em> <a href>", "filter_html_help" => TRUE, "filter_html_nofollow" => FALSE],
    ],
  ])->save();
  $e = Editor::load("cdm_filter");
  if (!$e) { $e = Editor::create(["format" => "cdm_filter", "editor" => "ckeditor5", "settings" => []]); }
  $e->setSettings(["toolbar" => ["items" => ["bold","DivManager"]], "plugins" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cdm_filter filter_html allowed_html has NO <div>"
