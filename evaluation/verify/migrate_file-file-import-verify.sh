#!/usr/bin/env bash
# Live-state verification for the file_import hard case. Prints PASS/FAIL and exits 0/1.
# PASS if a `migrate_plus.migration` config entity `mf_eval_file_import` exists AND some
# field mapping in its process pipeline uses this module's `file_import` process plugin.
# (Runtime execution of migrations is blocked on this install by an unrelated broken
# pathauto_pattern template, so we verify the built config entity + plugin, per api/patterns.md.)
# As a fallback we also PASS if a managed file entity was actually imported to the eval dir.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $m = \Drupal::entityTypeManager()->getStorage("migration")->load("mf_eval_file_import");
  $found = FALSE;
  if ($m) {
    $walk = function ($v) use (&$walk, &$found) {
      if (is_array($v)) {
        if (isset($v["plugin"]) && $v["plugin"] === "file_import") { $found = TRUE; }
        foreach ($v as $x) { $walk($x); }
      }
    };
    $walk($m->get("process"));
  }
  $imported = (bool) \Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => "public://eval-file-import/druplicon.png"]);
  $ok = ($m && $found) || $imported;
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($m?1:0) . " uses_file_import=" . ($found?1:0) . " imported=" . ($imported?1:0) . "\n";
' 2>/dev/null)

res=$(echo "$out" | grep -E '^(PASS|FAIL)')
echo "$res"
echo "$res" | grep -q '^PASS' && exit 0 || exit 1
