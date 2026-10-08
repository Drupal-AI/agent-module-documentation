#!/usr/bin/env bash
# Execution VERIFY: PASS when hide_default_button === true AND subscribe_hub_url === /eswsub-target.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("entity_share_websub_subscriber.settings");
  $ok = ($c->get("hide_default_button") == TRUE) && ($c->get("subscribe_hub_url") === "/eswsub-target");
  print ($ok ? "PASS" : "FAIL") . " hide=" . var_export($c->get("hide_default_button"), TRUE) . " url=" . var_export($c->get("subscribe_hub_url"), TRUE);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
