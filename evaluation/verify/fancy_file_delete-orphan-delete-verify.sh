#!/usr/bin/env bash
# Live-state verification for the "delete the orphaned managed file" task.
# PASS (exit 0) when the seeded orphan is fully gone: no file_managed row for
# filename ffd_eval_orphan_del.txt AND no leftover file_usage rows for it AND the physical
# file is off disk. FAIL (exit 1) otherwise (e.g. still present, or only soft-deleted).
# No arguments. Deprecation notices leak to stdout, so we grep the tagged PASS/FAIL line.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $db = \Drupal::database();
  $fs = \Drupal::service("file_system");
  $rows = $db->query("SELECT fid FROM {file_managed} WHERE filename = :n", [":n" => "ffd_eval_orphan_del.txt"])->fetchCol();
  $mrows = count($rows);
  $usage = 0;
  foreach ($rows as $fid) {
    $usage += (int) $db->query("SELECT COUNT(*) FROM {file_usage} WHERE fid = :f", [":f" => $fid])->fetchField();
  }
  $ondisk = file_exists($fs->realpath("public://") . "/ffd_eval_orphan_del.txt") ? 1 : 0;
  $pass = ($mrows === 0 && $usage === 0 && $ondisk === 0);
  print ($pass ? "PASS" : "FAIL") . " file_managed=" . $mrows . " file_usage=" . $usage . " ondisk=" . $ondisk . "\n";
' 2>/dev/null | grep -aE '^(PASS|FAIL)')
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
