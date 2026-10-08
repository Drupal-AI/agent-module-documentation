#!/usr/bin/env bash
# Introspection SETUP: create two CKEditor 5 formats — clh_active (Line Height button ON) and
# clh_plain (no Line Height) — so the agent must inspect toolbars to say which has it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  foreach (["clh_active" => ["bold","lineHeight"], "clh_plain" => ["bold","italic"]] as $fmt => $items) {
    if (!FilterFormat::load($fmt)) { FilterFormat::create(["format" => $fmt, "name" => strtoupper($fmt), "filters" => []])->save(); }
    $ed = Editor::load($fmt) ?: Editor::create(["format" => $fmt, "editor" => "ckeditor5"]);
    $ed->setSettings(["toolbar" => ["items" => $items], "plugins" => []])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: clh_active has lineHeight, clh_plain does not"
