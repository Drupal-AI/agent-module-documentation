#!/usr/bin/env bash
# Execution VERIFY: PASS when vwo.settings restricts the snippet to only the /vwo-landing path, i.e.
# filter.page.type == 'listinclude' AND filter.page.list contains '/vwo-landing'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("vwo.settings");
  $type = $c->get("filter.page.type");
  $list = (string) $c->get("filter.page.list");
  $ok = ($type === "listinclude") && (strpos($list, "/vwo-landing") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($type, TRUE) . " list=" . str_replace("\n", "|", $list) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
