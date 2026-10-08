#!/usr/bin/env bash
# Introspection SETUP: create text format tocjsf_intro with the Toc.js [toc] filter enabled.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("tocjsf_intro") ?: FilterFormat::create(["format"=>"tocjsf_intro","name"=>"TOCJSF Intro","filters"=>[]]);
  $f->setFilterConfig("toc_js_filter", ["status"=>TRUE, "weight"=>0, "settings"=>[]]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format tocjsf_intro has toc_js_filter enabled"
