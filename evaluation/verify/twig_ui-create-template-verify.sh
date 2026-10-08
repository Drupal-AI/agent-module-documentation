#!/usr/bin/env bash
# Execution VERIFY: PASS when a twig_template config entity twui_task exists, is enabled, has
# theme_suggestion page__front, and targets the olivero theme. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("twig_template")->load("twui_task");
  if (!$t) { print "FAIL missing\n"; return; }
  $sug = $t->get("theme_suggestion");
  $themes = $t->get("themes") ?: [];
  $status = (bool) $t->get("status");
  $ok = ($sug === "page__front" && in_array("olivero", $themes, TRUE) && $status);
  print ($ok ? "PASS" : "FAIL") . " suggestion=" . var_export($sug, TRUE) . " themes=" . implode(",", $themes) . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
