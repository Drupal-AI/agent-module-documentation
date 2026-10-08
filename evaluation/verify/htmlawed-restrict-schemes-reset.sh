#!/usr/bin/env bash
# Execution RESET: create format htmlawed_schemes with filter_htmlawed ENABLED but no
# scheme restriction, so verify FAILS until the agent adds a schemes rule. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("htmlawed_schemes") ?: FilterFormat::create(["format"=>"htmlawed_schemes","name"=>"Htmlawed Schemes"]);
  $f->setFilterConfig("filter_htmlawed", ["status"=>TRUE, "weight"=>50, "settings"=>["config"=>"'\''safe'\'' => 1, '\''elements'\'' => '\''a, p, strong, img'\''", "spec"=>"", "help"=>"", "helplong"=>""]]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: filter.format.htmlawed_schemes enabled, no schemes restriction"
