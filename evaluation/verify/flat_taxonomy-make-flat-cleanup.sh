#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  if ($v = Vocabulary::load("flattax_task")) { $v->delete(); }
' >/dev/null 2>&1
echo "cleanup: vocabulary flattax_task removed"
