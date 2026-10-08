#!/usr/bin/env bash
# Execution RESET/CLEANUP: delete ft_twig_expert so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f = FilterFormat::load("ft_twig_expert")) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ft_twig_expert removed"
