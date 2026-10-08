#!/usr/bin/env bash
# Introspection SETUP: create a text format nbsp_eval with the NBSP cleanup filter enabled,
# so the agent can discover which filter provides the non-breaking-space handling. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if (!FilterFormat::load("nbsp_eval")) {
    FilterFormat::create(["format"=>"nbsp_eval","name"=>"NBSP Eval","filters"=>["nbsp_cleaner_filter"=>["status"=>TRUE,"weight"=>20]]])->save();
  }
' >/dev/null 2>&1
echo "setup: filter.format.nbsp_eval has nbsp_cleaner_filter enabled"
