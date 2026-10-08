#!/usr/bin/env bash
# Execution VERIFY: PASS when feed type "cf_remote" imports Commerce products
# (processor entity:commerce_product) from a remote URL (http/download fetcher).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\feeds\Entity\FeedType;
  $ft = FeedType::load("cf_remote");
  $proc = $ft ? $ft->getProcessor()->getPluginId() : "none";
  $fetch = $ft ? $ft->getFetcher()->getPluginId() : "none";
  $ok = ($ft && $proc === "entity:commerce_product" && $fetch === "http");
  print ($ok ? "PASS" : "FAIL") . " processor=" . $proc . " fetcher=" . $fetch . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
