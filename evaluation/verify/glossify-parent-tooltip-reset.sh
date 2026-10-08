#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("gl_p_build")) { $f->delete(); }
  FilterFormat::create(["format"=>"gl_p_build","name"=>"gl_p_build","filters"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format gl_p_build created with NO glossify filter"
