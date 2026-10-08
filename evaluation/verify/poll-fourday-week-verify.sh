#!/usr/bin/env bash
# Live-state verification for the "four-day work week" poll task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Checks a `poll` entity exists that: mentions "four-day work week", is active (open),
# is published, and has at least the two choices Yes and No.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("poll");
  $ok = FALSE; $detail = "";
  foreach ($storage->loadMultiple() as $p) {
    $q = strtolower($p->label());
    if (strpos($q, "four-day work week") === FALSE && strpos($q, "four day work week") === FALSE) { continue; }
    $active = $p->isOpen();
    $pub = (bool) $p->get("status")->value;
    $labels = array_map("strtolower", array_values($p->getOptions()));
    $hasYes = FALSE; $hasNo = FALSE;
    foreach ($labels as $l) { if (strpos($l, "yes") !== FALSE) { $hasYes = TRUE; } if (strpos($l, "no") !== FALSE) { $hasNo = TRUE; } }
    if ($active && $pub && $hasYes && $hasNo) { $ok = TRUE; }
    $detail = "id=".$p->id()." active=".($active?1:0)." pub=".($pub?1:0)." choices=".count($labels);
    if ($ok) { break; }
  }
  print ($ok ? "PASS " : "FAIL ") . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -qa '^PASS' && exit 0 || exit 1
