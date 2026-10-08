#!/usr/bin/env bash
# Introspection CLEANUP: remove the mdft_eval display and view mode created by the matching
# setup. The submodule is left uninstalled, which is the baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  if ($d = EntityViewDisplay::load("node.article.mdft_eval")) { $d->delete(); }
  if ($m = EntityViewMode::load("node.mdft_eval")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.mdft_eval display and node.mdft_eval view mode removed"
