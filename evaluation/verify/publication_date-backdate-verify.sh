#!/usr/bin/env bash
# Live-state verification for the "back-date an Article's publication date" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Checks: a PUBLISHED Article titled 'PD Backdated Article' exists whose published_at
# timestamp falls on 1 January 2020 (a ~1-day window each side absorbs timezone offsets:
# 2019-12-31 00:00 UTC .. 2020-01-02 00:00 UTC == 1577750400 .. 1578009600).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $lo = 1577750400; $hi = 1578009600;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("type", "article")
    ->condition("title", "PD Backdated Article")
    ->condition("status", 1)
    ->execute();
  $ok = FALSE; $val = "none";
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadMultiple($ids) as $n) {
    $ts = $n->get("published_at")->value;
    $val = var_export($ts, TRUE);
    if ($ts !== NULL && $ts >= $lo && $ts <= $hi) { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . " published_at=" . $val . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
