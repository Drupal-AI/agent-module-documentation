#!/usr/bin/env bash
# Execution VERIFY: PASS when the site default amount formatter is currency_intl. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $id = \Drupal::config("currency.amount_formatting")->get("plugin_id");
  print (($id === "currency_intl") ? "PASS" : "FAIL") . " plugin_id=" . var_export($id, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
