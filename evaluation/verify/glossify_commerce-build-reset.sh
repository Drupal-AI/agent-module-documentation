#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f = FilterFormat::load("gl_com_build")) { $f->delete(); } FilterFormat::create(["format"=>"gl_com_build","name"=>"gl_com_build","filters"=>[]])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format gl_com_build created with NO glossify filter"
