#!/usr/bin/env bash
# Execution CLEANUP: delete the node.article.md_task display and the md_task view mode.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  if ($d = EntityViewDisplay::load("node.article.md_task")) { $d->delete(); }
  if ($m = EntityViewMode::load("node.md_task")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.md_task display and node.md_task view mode removed"
