#!/usr/bin/env bash
# Live-state verification for the "create a date_recur interpreter" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Checks a date_recur_interpreter config entity (id eval_interpreter) exists and uses the
# `rl` plugin (the shipped interpreter plugin). No assertion on label text.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ent = FALSE; $plug = FALSE; $detail = "";
  if ($e = \Drupal\date_recur\Entity\DateRecurInterpreter::load("eval_interpreter")) {
    $ent = TRUE;
    $pid = (string) $e->get("plugin");
    if ($pid === "rl") { $plug = TRUE; }
    $detail = "plugin=" . $pid . " label=" . (string) $e->label();
  }
  $ok = $ent && $plug;
  print ($ok ? "PASS" : "FAIL") . " ent=" . ($ent?1:0) . " plug=" . ($plug?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
