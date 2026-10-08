#!/usr/bin/env bash
# Introspection CLEANUP: delete the node.article.md_byline display and the md_byline view mode
# created by the matching setup. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  if ($d = EntityViewDisplay::load("node.article.md_byline")) { $d->delete(); }
  if ($m = EntityViewMode::load("node.md_byline")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.md_byline display and node.md_byline view mode removed"
