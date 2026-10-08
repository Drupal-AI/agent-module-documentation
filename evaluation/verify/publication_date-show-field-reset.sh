#!/usr/bin/env bash
# Reset for the "show the publication date on the Article display" task: ensure published_at
# is NOT a visible component on the node.article default view display (it ships hidden), so
# verify FAILs before the agent configures it. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  if ($d->getComponent("published_at") !== NULL) { $d->removeComponent("published_at")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: published_at removed from node.article default view display"
