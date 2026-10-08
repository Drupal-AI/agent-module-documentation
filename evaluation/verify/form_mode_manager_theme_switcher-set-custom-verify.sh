#!/usr/bin/env bash
# Execution VERIFY: PASS when node.reviewer form mode uses a specific custom theme 'claro', i.e.
# type.node_reviewer === '_custom' AND form_mode.node_reviewer === 'claro'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("form_mode_manager_theme_switcher.settings");
  $t = $c->get("type.node_reviewer"); $th = $c->get("form_mode.node_reviewer");
  $ok = ($t === "_custom" && $th === "claro");
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($t, TRUE) . " theme=" . var_export($th, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
