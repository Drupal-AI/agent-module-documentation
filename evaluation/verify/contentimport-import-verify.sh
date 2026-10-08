#!/usr/bin/env bash
# Execution VERIFY (contentimport): PASS when both Article nodes 'CI Import Alpha' and
# 'CI Import Beta' exist. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $st = \Drupal::entityTypeManager()->getStorage("node");
  $a = count($st->loadByProperties(["type" => "article", "title" => "CI Import Alpha"]));
  $b = count($st->loadByProperties(["type" => "article", "title" => "CI Import Beta"]));
  $ok = ($a >= 1 && $b >= 1);
  print ($ok ? "PASS" : "FAIL") . " alpha=" . $a . " beta=" . $b . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
