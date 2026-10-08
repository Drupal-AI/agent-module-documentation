#!/usr/bin/env bash
# Introspection CLEANUP: remove ft_twig_probe.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f = FilterFormat::load("ft_twig_probe")) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ft_twig_probe removed"
