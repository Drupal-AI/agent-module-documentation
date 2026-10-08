#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("gl_node_known")) { $f->delete(); }
  FilterFormat::create(["format"=>"gl_node_known","name"=>"gl_node_known","filters"=>["glossify_node"=>["status"=>TRUE,"settings"=>["glossify_node_case_sensitivity"=>TRUE,"glossify_node_first_only"=>FALSE,"glossify_node_ignore_tags"=>"","glossify_node_type"=>"links","glossify_node_tooltip_truncate"=>FALSE,"glossify_node_bundles"=>"article","glossify_node_urlpattern"=>"/wiki/[id]","glossify_node_synonyms_field"=>""]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: format gl_node_known (glossify_node bundles=article type=links urlpattern=/wiki/[id])"
