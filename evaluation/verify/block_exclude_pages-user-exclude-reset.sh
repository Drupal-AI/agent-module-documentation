#!/usr/bin/env bash
# HARD reset: ensure the block the agent must create does NOT yet exist, so verify
# FAILs on empty state. The agent will (re)create block `bep_user_promo`.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($b = \Drupal::entityTypeManager()->getStorage("block")->load("bep_user_promo")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block bep_user_promo removed (absent)"
