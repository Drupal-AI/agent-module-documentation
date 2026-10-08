#!/usr/bin/env bash
# Execution CLEANUP: remove the Article Title base field override (baseline: none). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Field\Entity\BaseFieldOverride;
  if ($o = BaseFieldOverride::load("node.article.uid")) { $o->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.uid base field override removed"
