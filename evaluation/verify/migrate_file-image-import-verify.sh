#!/usr/bin/env bash
# Live-state verification for the image_import hard case. Prints PASS/FAIL and exits 0/1.
# PASS if a `migrate_plus.migration` config entity `mf_eval_image_import` exists AND some
# field mapping in its process pipeline uses this module's `image_import` process plugin.
# (Migration runtime is blocked on this install by an unrelated broken pathauto_pattern
# template, so we verify the built config entity + plugin, per api/patterns.md.)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $m = \Drupal::entityTypeManager()->getStorage("migration")->load("mf_eval_image_import");
  $found = FALSE;
  if ($m) {
    $walk = function ($v) use (&$walk, &$found) {
      if (is_array($v)) {
        if (isset($v["plugin"]) && $v["plugin"] === "image_import") { $found = TRUE; }
        foreach ($v as $x) { $walk($x); }
      }
    };
    $walk($m->get("process"));
  }
  $ok = $m && $found;
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($m?1:0) . " uses_image_import=" . ($found?1:0) . "\n";
' 2>/dev/null)

res=$(echo "$out" | grep -E '^(PASS|FAIL)')
echo "$res"
echo "$res" | grep -q '^PASS' && exit 0 || exit 1
