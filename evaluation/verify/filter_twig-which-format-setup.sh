#!/usr/bin/env bash
# Introspection SETUP: two formats — ft_twig_on (filter_twig enabled) and ft_twig_off (present but disabled).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  foreach (["ft_twig_on" => TRUE, "ft_twig_off" => FALSE] as $id => $on) {
    $f = FilterFormat::load($id) ?: FilterFormat::create(["format" => $id, "name" => strtoupper($id)]);
    $f->setFilterConfig("filter_twig", ["id" => "filter_twig", "status" => $on, "weight" => 0, "settings" => []]);
    $f->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ft_twig_on (status=TRUE), ft_twig_off (status=FALSE)"
