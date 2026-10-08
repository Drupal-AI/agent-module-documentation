#!/usr/bin/env bash
# Execution RESET: create text format tocjsf_build WITHOUT the [toc] filter, so verify FAILS until
# the agent enables toc_js_filter on it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("tocjsf_build")) { $f->delete(); }
  FilterFormat::create(["format"=>"tocjsf_build","name"=>"TOCJSF Build","filters"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format tocjsf_build present without toc_js_filter"
