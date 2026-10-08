#!/usr/bin/env bash
# Live-state verification for the "build a view whose cache plugin is custom_tag" task.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# PASS when a view `vcct_hard_report` exists AND its default display cache option is
# type == "custom_tag" AND the custom_tag list contains the required tag `eval:hard:report`.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("vcct_hard_report");
  if (!$v) { print "FAIL view-missing\n"; return; }
  $cache = $v->getDisplay("default")["display_options"]["cache"] ?? [];
  $type = $cache["type"] ?? "";
  $tags = $cache["options"]["custom_tag"] ?? "";
  $isPlugin = $type === "custom_tag";
  $hasTag = stripos($tags, "eval:hard:report") !== FALSE;
  $ok = $isPlugin && $hasTag;
  print (($ok ? "PASS" : "FAIL") . " type=$type hasTag=" . ($hasTag?1:0) . "\n");
' 2>/dev/null)

echo "$out" | grep -E '^(PASS|FAIL)'
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
