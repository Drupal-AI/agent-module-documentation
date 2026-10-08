#!/usr/bin/env bash
# Execution VERIFY: PASS when text format oe_secure exists with obfuscate_email enabled and
# configured for click-to-reveal with label 'Reveal'. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("filter.format.oe_secure");
  $status = $c->get("filters.obfuscate_email.status");
  $click  = $c->get("filters.obfuscate_email.settings.click");
  $label  = $c->get("filters.obfuscate_email.settings.click_label");
  $ok = ($status === TRUE && $click == TRUE && $label === "Reveal");
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . " click=" . var_export($click, TRUE) . " label=" . var_export($label, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
