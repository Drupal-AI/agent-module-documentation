#!/usr/bin/env bash
# Live-state verification for the "favorite programming language" poll task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Checks a `poll` entity exists that: mentions "favorite programming language", is active
# (open), is published, and has at least 3 choices including Python, Rust and Go.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("poll");
  $ok = FALSE; $detail = "";
  foreach ($storage->loadMultiple() as $p) {
    $q = strtolower($p->label());
    if (strpos($q, "favorite programming language") === FALSE
        && strpos($q, "favourite programming language") === FALSE) { continue; }
    $active = $p->isOpen();
    $pub = (bool) $p->get("status")->value;
    $labels = array_map("strtolower", array_values($p->getOptions()));
    $joined = implode("|", $labels);
    $hasPython = strpos($joined, "python") !== FALSE;
    $hasRust = strpos($joined, "rust") !== FALSE;
    $hasGo = FALSE;
    foreach ($labels as $l) { if ($l === "go" || strpos($l, "go ") === 0 || strpos($l, "golang") !== FALSE) { $hasGo = TRUE; } }
    if ($active && $pub && count($labels) >= 3 && $hasPython && $hasRust && $hasGo) { $ok = TRUE; }
    $detail = "id=".$p->id()." active=".($active?1:0)." pub=".($pub?1:0)." choices=".count($labels)." [".$joined."]";
    if ($ok) { break; }
  }
  print ($ok ? "PASS " : "FAIL ") . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -qa '^PASS' && exit 0 || exit 1
