#!/usr/bin/env bash
# Execution VERIFY: PASS when acquia_perz.entity_config has view_modes.node.article.default with
# render_role === 'anonymous'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vm = \Drupal::config("acquia_perz.entity_config")->get("view_modes");
  $c = $vm["node"]["article"]["default"] ?? NULL;
  $role = is_array($c) ? ($c["render_role"] ?? NULL) : NULL;
  $ok = is_array($c) && $role === "anonymous";
  print ($ok ? "PASS" : "FAIL") . " default=" . var_export($c, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
