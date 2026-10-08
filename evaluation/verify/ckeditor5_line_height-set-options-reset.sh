#!/usr/bin/env bash
# Execution RESET: ensure format 'clh_opts' exists with the Line Height button already enabled
# but using the DEFAULT option list (so verify for a specific custom list FAILS until changed).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("clh_opts")) { FilterFormat::create(["format" => "clh_opts", "name" => "CLH Opts", "filters" => []])->save(); }
  $ed = Editor::load("clh_opts") ?: Editor::create(["format" => "clh_opts", "editor" => "ckeditor5"]);
  $ed->setSettings([
    "toolbar" => ["items" => ["bold", "lineHeight"]],
    "plugins" => ["ckeditor5_line_height_line_height" => ["line_height_options" => ["0","0.5","1","1.5","2","2.5","3","3.5","4","4.5","5","5.5","6","6.5"]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: clh_opts has lineHeight with DEFAULT options"
