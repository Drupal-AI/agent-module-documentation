#!/usr/bin/env bash
# Introspection SETUP: text format tocjsf_sel with [toc] filter enabled + selectors h2,h3,h4.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("tocjsf_sel") ?: FilterFormat::create(["format"=>"tocjsf_sel","name"=>"TOCJSF Sel","filters"=>[]]);
  $f->setFilterConfig("toc_js_filter", ["status"=>TRUE, "weight"=>0, "settings"=>["selectors"=>"h2,h3,h4"]]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tocjsf_sel toc_js_filter selectors=h2,h3,h4"
