#!/usr/bin/env bash
# Introspection CLEANUP: remove the Article 'created' base field override (baseline: none). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Field\Entity\BaseFieldOverride;
  if ($o = BaseFieldOverride::load("node.article.created")) { $o->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.created base field override removed"
