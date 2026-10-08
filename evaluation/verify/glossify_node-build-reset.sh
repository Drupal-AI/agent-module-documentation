#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f = FilterFormat::load("gl_node_build")) { $f->delete(); } FilterFormat::create(["format"=>"gl_node_build","name"=>"gl_node_build","filters"=>[]])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format gl_node_build created with NO glossify filter"
