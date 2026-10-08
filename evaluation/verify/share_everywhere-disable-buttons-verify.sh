#!/usr/bin/env bash
# Execution VERIFY: PASS when whatsapp+viber disabled and alignment=right. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("share_everywhere.settings");
  $ok = ((int) $c->get("buttons.whatsapp.enabled") === 0) && ((int) $c->get("buttons.viber.enabled") === 0) && ($c->get("alignment") === "right");
  print ($ok ? "PASS" : "FAIL") . " wa=" . var_export($c->get("buttons.whatsapp.enabled"), TRUE) . " vi=" . var_export($c->get("buttons.viber.enabled"), TRUE) . " align=" . var_export($c->get("alignment"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
