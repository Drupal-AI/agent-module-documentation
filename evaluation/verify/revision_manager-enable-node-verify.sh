#!/usr/bin/env bash
# Execution VERIFY: PASS when revision_manager.settings has node enabled AND its Amount plugin
# default is enabled with a keep count of 3. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("revision_manager.settings");
  $enabled = (bool) (($c->get("enabled_entities") ?? [])["node"] ?? FALSE);
  $amt = $c->get("defaults")["node"]["amount"] ?? [];
  $status = (bool) ($amt["status"] ?? FALSE);
  $count = $amt["settings"]["amount"] ?? NULL;
  $ok = $enabled && $status && ((int) $count === 3);
  print ($ok ? "PASS" : "FAIL") . " node_enabled=" . var_export($enabled, TRUE)
    . " amount_status=" . var_export($status, TRUE) . " amount=" . var_export($count, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
