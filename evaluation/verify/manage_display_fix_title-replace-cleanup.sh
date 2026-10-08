#!/usr/bin/env bash
# Execution CLEANUP: delete the mdft_task display and view mode. Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  if ($d = EntityViewDisplay::load("node.article.mdft_task")) { $d->delete(); }
  if ($m = EntityViewMode::load("node.mdft_task")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.mdft_task display and node.mdft_task view mode removed"
