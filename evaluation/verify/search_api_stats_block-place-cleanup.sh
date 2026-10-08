#!/usr/bin/env bash
# Execution CLEANUP: remove the placed block and the sasblk_idx index created for the test.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Index;
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->get("plugin") === "search_api_stats_block:sasblk_idx") { $b->delete(); }
  }
  if ($i = Index::load("sasblk_idx")) { $i->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block + sasblk_idx index removed"
