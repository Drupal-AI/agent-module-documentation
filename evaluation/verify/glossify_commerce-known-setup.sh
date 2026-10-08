#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("gl_com_known")) { $f->delete(); }
  FilterFormat::create(["format"=>"gl_com_known","name"=>"gl_com_known","filters"=>["glossify_commerce_product"=>["status"=>TRUE,"settings"=>["case_sensitivity"=>TRUE,"first_only"=>FALSE,"ignore_tags"=>"","glossify_type"=>"links","tooltip_truncate"=>FALSE,"bundles"=>"default","urlpattern"=>"/shop/[id]","synonyms_field"=>""]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: format gl_com_known (glossify_commerce_product bundles=default type=links urlpattern=/shop/[id])"
