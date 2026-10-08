#!/usr/bin/env bash
# Introspection SETUP: create text format 'htmlawed_med1' using filter_htmlawed with a
# distinctive deny_attribute (data-hlx) so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("htmlawed_med1") ?: FilterFormat::create(["format"=>"htmlawed_med1","name"=>"Htmlawed Med1"]);
  $f->setFilterConfig("filter_htmlawed", [
    "status"=>TRUE, "weight"=>50,
    "settings"=>["config"=>"'\''safe'\'' => 1, '\''elements'\'' => '\''a, em, strong, p'\'', '\''deny_attribute'\'' => '\''id, style, data-hlx'\''", "spec"=>"", "help"=>"", "helplong"=>""],
  ]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: filter.format.htmlawed_med1 htmLawed denies id, style, data-hlx"
