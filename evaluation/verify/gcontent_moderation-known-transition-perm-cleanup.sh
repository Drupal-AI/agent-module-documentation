#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\workflows\Entity\Workflow;
  if ($w = Workflow::load("gcmod_editorial")) { $w->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: workflow gcmod_editorial removed"
