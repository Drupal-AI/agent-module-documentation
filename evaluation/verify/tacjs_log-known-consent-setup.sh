#!/usr/bin/env bash
# Introspection SETUP: insert a proof-of-consent row with a distinctive service string into the
# tacjslog table so an inspecting agent can read it back. Idempotent (clears prior probe rows).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $db->delete("tacjslog")->condition("services_allowed","tacjs_probe_consent")->execute();
  $db->insert("tacjslog")->fields([
    "timestamp" => \Drupal::time()->getCurrentTime(),
    "ip_address" => "203.0.113.7",
    "services_allowed" => "tacjs_probe_consent",
  ])->execute();
' >/dev/null 2>&1
echo "setup: tacjslog row services_allowed=tacjs_probe_consent inserted"
