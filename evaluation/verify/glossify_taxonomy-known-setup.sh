#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("gl_tax_known")) { $f->delete(); }
  FilterFormat::create(["format"=>"gl_tax_known","name"=>"gl_tax_known","filters"=>["glossify_taxonomy"=>["status"=>TRUE,"settings"=>["glossify_taxonomy_case_sensitivity"=>TRUE,"glossify_taxonomy_first_only"=>TRUE,"glossify_taxonomy_ignore_tags"=>"","glossify_taxonomy_type"=>"tooltips","glossify_taxonomy_tooltip_truncate"=>FALSE,"glossify_taxonomy_vocabs"=>"tags","glossify_taxonomy_urlpattern"=>"/taxonomy/term/[id]","glossify_taxonomy_synonyms_field"=>""]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: format gl_tax_known (glossify_taxonomy vocabs=tags type=tooltips)"
