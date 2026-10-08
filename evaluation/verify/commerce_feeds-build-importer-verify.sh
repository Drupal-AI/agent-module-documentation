#!/usr/bin/env bash
# Execution VERIFY: PASS when a feed type "cf_import" exists whose processor is the Commerce
# Feeds product processor (entity:commerce_product). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\feeds\Entity\FeedType;
  $ft = FeedType::load("cf_import");
  $proc = $ft ? $ft->getProcessor()->getPluginId() : "none";
  $ok = ($ft && $proc === "entity:commerce_product");
  print ($ok ? "PASS" : "FAIL") . " processor=" . $proc . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
