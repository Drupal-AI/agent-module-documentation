#!/usr/bin/env bash
# HARD reset: ensure block `bep_sitewide_banner` does NOT yet exist, so verify FAILs
# on empty state. The agent will create it (sitewide except the front page).
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($b = \Drupal::entityTypeManager()->getStorage("block")->load("bep_sitewide_banner")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block bep_sitewide_banner removed (absent)"
