#!/usr/bin/env bash
# Introspection CLEANUP: delete the node.article.md_eval display and the md_eval view mode
# created by the matching setup. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  if ($d = EntityViewDisplay::load("node.article.md_eval")) { $d->delete(); }
  if ($m = EntityViewMode::load("node.md_eval")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.md_eval display and node.md_eval view mode removed"
