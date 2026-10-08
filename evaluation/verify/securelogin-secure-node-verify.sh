#!/usr/bin/env bash
# Execution VERIFY: PASS when node_form is secured, i.e. present in securelogin.settings forms
# or other_forms. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("securelogin.settings");
  $all = array_merge((array) ($c->get("forms") ?? []), (array) ($c->get("other_forms") ?? []));
  $ok = in_array("node_form", $all, TRUE);
  print ($ok ? "PASS" : "FAIL") . " secured=" . implode(",", $all) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
