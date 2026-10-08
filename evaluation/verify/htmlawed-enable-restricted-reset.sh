#!/usr/bin/env bash
# Execution RESET: create text format htmlawed_task with filter_htmlawed present but
# DISABLED and default-ish config (no restricted element list), so verify FAILS until the
# agent enables it and restricts elements. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("htmlawed_task") ?: FilterFormat::create(["format"=>"htmlawed_task","name"=>"Htmlawed Task"]);
  $f->setFilterConfig("filter_htmlawed", ["status"=>FALSE, "weight"=>50, "settings"=>["config"=>"'\''safe'\'' => 1", "spec"=>"", "help"=>"", "helplong"=>""]]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: filter.format.htmlawed_task filter_htmlawed disabled"
