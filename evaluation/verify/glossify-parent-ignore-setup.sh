#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("gl_p_ignore")) { $f->delete(); }
  FilterFormat::create(["format"=>"gl_p_ignore","name"=>"gl_p_ignore","filters"=>["glossify_taxonomy"=>["status"=>TRUE,"settings"=>["glossify_taxonomy_case_sensitivity"=>TRUE,"glossify_taxonomy_first_only"=>TRUE,"glossify_taxonomy_ignore_tags"=>"h1,h2,gl_marker","glossify_taxonomy_type"=>"tooltips","glossify_taxonomy_tooltip_truncate"=>FALSE,"glossify_taxonomy_vocabs"=>"tags","glossify_taxonomy_urlpattern"=>"/taxonomy/term/[id]","glossify_taxonomy_synonyms_field"=>""]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: format gl_p_ignore (glossify_taxonomy ignore_tags=h1,h2,gl_marker)"
