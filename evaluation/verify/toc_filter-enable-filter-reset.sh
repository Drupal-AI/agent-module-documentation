#!/usr/bin/env bash
# Execution RESET: create a text format WITHOUT the TOC filter so verify FAILS until enabled.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("toc_filter_hard")) { $f->delete(); }
  FilterFormat::create(["format" => "toc_filter_hard", "name" => "TOC Filter Hard"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format toc_filter_hard exists WITHOUT the toc_filter filter"
