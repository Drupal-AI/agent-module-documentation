#!/usr/bin/env bash
# Introspection CLEANUP: remove the cvfb_options block and the raw test view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("cvfb_options")) { $b->delete(); }
  \Drupal::service("config.storage")->delete("views.view.view_simple_exposed_filters");
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cvfb_options block + test view removed"
