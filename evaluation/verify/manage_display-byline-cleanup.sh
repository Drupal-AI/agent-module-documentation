#!/usr/bin/env bash
# Execution CLEANUP: delete the node.article.md_author display and the md_author view mode.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  if ($d = EntityViewDisplay::load("node.article.md_author")) { $d->delete(); }
  if ($m = EntityViewMode::load("node.md_author")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.md_author display and node.md_author view mode removed"
