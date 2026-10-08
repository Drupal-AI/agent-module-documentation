#!/usr/bin/env bash
# Live-state verification for the file_remote_url hard case. Prints PASS/FAIL and exits 0/1.
# PASS if a `migrate_plus.migration` config entity `mf_eval_remote_url` exists AND some
# field mapping in its process pipeline uses this module's `file_remote_url` process plugin
# (the "register a remote URL as a file entity without downloading" variant).
# (Migration runtime is blocked on this install by an unrelated broken pathauto_pattern
# template, so we verify the built config entity + plugin, per api/patterns.md.)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $m = \Drupal::entityTypeManager()->getStorage("migration")->load("mf_eval_remote_url");
  $found = FALSE;
  if ($m) {
    $walk = function ($v) use (&$walk, &$found) {
      if (is_array($v)) {
        if (isset($v["plugin"]) && $v["plugin"] === "file_remote_url") { $found = TRUE; }
        foreach ($v as $x) { $walk($x); }
      }
    };
    $walk($m->get("process"));
  }
  $ok = $m && $found;
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($m?1:0) . " uses_file_remote_url=" . ($found?1:0) . "\n";
' 2>/dev/null)

res=$(echo "$out" | grep -E '^(PASS|FAIL)')
echo "$res"
echo "$res" | grep -q '^PASS' && exit 0 || exit 1
