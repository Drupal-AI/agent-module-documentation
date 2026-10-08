#!/usr/bin/env bash
# Live-state verification for the "build an active, dismissible outage alert" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if a sitewide_alert entity exists that is ACTIVE (status=1), dismissible,
# uses the 'primary' style, and whose message contains the required outage text.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $needle = "temporarily offline for maintenance";
  $s = \Drupal::entityTypeManager()->getStorage("sitewide_alert");
  $hit = FALSE;
  foreach ($s->loadMultiple() as $a) {
    $msg = (string) ($a->get("message")->value ?? "");
    $active = (int) $a->get("status")->value === 1;
    $dismiss = (bool) $a->get("dismissible")->value;
    $style = (string) ($a->get("style")->value ?? "");
    if (stripos($msg, $needle) !== FALSE && $active && $dismiss && $style === "primary") { $hit = TRUE; }
  }
  print ($hit ? "PASS" : "FAIL") . " match_active_dismissible_primary=" . ($hit?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
