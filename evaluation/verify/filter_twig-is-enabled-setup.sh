#!/usr/bin/env bash
# Introspection SETUP: format ft_twig_probe with filter_twig enabled.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("ft_twig_probe") ?: FilterFormat::create(["format" => "ft_twig_probe", "name" => "FT Twig Probe"]);
  $f->setFilterConfig("filter_twig", ["id" => "filter_twig", "status" => TRUE, "weight" => 0, "settings" => []]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ft_twig_probe filter_twig status=TRUE"
