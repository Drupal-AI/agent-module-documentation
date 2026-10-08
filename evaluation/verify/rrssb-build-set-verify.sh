#!/usr/bin/env bash
# Execution VERIFY: PASS when rrssb_task exists with email, facebook, linkedin all enabled. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\rrssb\Entity\RRSSBButtonSet;
  $s = RRSSBButtonSet::load("rrssb_task");
  $ok = FALSE; $found = "none";
  if ($s) {
    $chosen = $s->get("chosen") ?: [];
    $en = function($k) use ($chosen) { return !empty($chosen[$k]) && !empty($chosen[$k]["enabled"]); };
    $found = implode(",", array_keys(array_filter($chosen, fn($c) => !empty($c["enabled"]))));
    $ok = $en("email") && $en("facebook") && $en("linkedin");
  }
  print ($ok ? "PASS" : "FAIL") . " enabled=[" . $found . "]\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
