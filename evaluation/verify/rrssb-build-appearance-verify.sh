#!/usr/bin/env bash
# Execution VERIFY: PASS when rrssb_align has appearance.alignRight === true and prefix 'Share this:'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\rrssb\Entity\RRSSBButtonSet;
  $s = RRSSBButtonSet::load("rrssb_align");
  $ok = FALSE; $ar = "none"; $pf = "none";
  if ($s) {
    $app = $s->get("appearance") ?: [];
    $ar = $app["alignRight"] ?? NULL;
    $pf = $s->get("prefix");
    $ok = ($ar === TRUE || $ar === 1 || $ar === "1") && ($pf === "Share this:");
  }
  print ($ok ? "PASS" : "FAIL") . " alignRight=" . var_export($ar, TRUE) . " prefix=" . var_export($pf, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
