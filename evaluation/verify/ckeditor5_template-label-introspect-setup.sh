#!/usr/bin/env bash
# MEDIUM (introspection) setup: enable the ckeditor5_template "template" toolbar item on the
# basic_html text format and point it at a KNOWN template file, so an agent inspecting the live
# editor config can report which format has the Template button and which template file it uses.
# Baseline (button absent) is restored by the matching -cleanup.sh. No arguments.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $e = \Drupal\editor\Entity\Editor::load("basic_html");
  $s = $e->getSettings();
  if (!in_array("template", $s["toolbar"]["items"], TRUE)) { $s["toolbar"]["items"][] = "template"; }
  $s["plugins"]["ckeditor5_template_template"] = [
    "file_path" => "/modules/contrib/ckeditor5_template/template/ckeditor5_template.json.example",
    "custom_toolbar_text" => "Reusable snippets",
    "show_toolbar_text" => 1,
  ];
  $e->setSettings($s);
  $e->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: basic_html has the template toolbar item + ckeditor5_template.json.example configured"
