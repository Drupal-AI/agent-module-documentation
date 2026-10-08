#!/usr/bin/env bash
# Introspection SETUP: two formats; htmlawed_on has filter_htmlawed enabled, htmlawed_off
# has it present but disabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $on = FilterFormat::load("htmlawed_on") ?: FilterFormat::create(["format"=>"htmlawed_on","name"=>"Htmlawed On"]);
  $on->setFilterConfig("filter_htmlawed", ["status"=>TRUE, "weight"=>50, "settings"=>["config"=>"'\''safe'\'' => 1", "spec"=>"", "help"=>"", "helplong"=>""]]);
  $on->save();
  $off = FilterFormat::load("htmlawed_off") ?: FilterFormat::create(["format"=>"htmlawed_off","name"=>"Htmlawed Off"]);
  $off->setFilterConfig("filter_htmlawed", ["status"=>FALSE, "weight"=>50, "settings"=>["config"=>"'\''safe'\'' => 1", "spec"=>"", "help"=>"", "helplong"=>""]]);
  $off->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: htmlawed_on (enabled) vs htmlawed_off (disabled)"
