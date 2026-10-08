#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("gl_tax_url")) { $f->delete(); }
  FilterFormat::create(["format"=>"gl_tax_url","name"=>"gl_tax_url","filters"=>["glossify_taxonomy"=>["status"=>TRUE,"settings"=>["glossify_taxonomy_case_sensitivity"=>FALSE,"glossify_taxonomy_first_only"=>TRUE,"glossify_taxonomy_ignore_tags"=>"","glossify_taxonomy_type"=>"links","glossify_taxonomy_tooltip_truncate"=>FALSE,"glossify_taxonomy_vocabs"=>"tags","glossify_taxonomy_urlpattern"=>"/gl-term/[id]","glossify_taxonomy_synonyms_field"=>""]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: format gl_tax_url (glossify_taxonomy type=links urlpattern=/gl-term/[id])"
