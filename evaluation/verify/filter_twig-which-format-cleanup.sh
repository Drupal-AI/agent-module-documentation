#!/usr/bin/env bash
# Introspection CLEANUP: remove both test formats.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  foreach (["ft_twig_on","ft_twig_off"] as $id) { if ($f = FilterFormat::load($id)) { $f->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ft_twig_on / ft_twig_off removed"
