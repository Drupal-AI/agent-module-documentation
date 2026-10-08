#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = (\Drupal::config("entity_share_websub_subscriber.settings")->get("break_subscription_on_edit") == TRUE);
  print $ok ? "PASS" : "FAIL";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
