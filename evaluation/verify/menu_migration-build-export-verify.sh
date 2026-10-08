#!/usr/bin/env bash
# Execution VERIFY: PASS when an mm_export_type entity mm_mig_export exists with destination
# 'codebase', format 'json', and the main menu in its menus list. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\menu_migration\Entity\ExportType;
  $e = ExportType::load("mm_mig_export");
  if (!$e) { print "FAIL no-entity\n"; return; }
  $dc = $e->get("destination_config") ?: [];
  $menus = $dc["menus"] ?? [];
  $menus = is_array($menus) ? $menus : [$menus];
  $ok = ($e->get("destination") === "codebase")
    && (($dc["format"] ?? NULL) === "json")
    && in_array("main", $menus, TRUE);
  print ($ok ? "PASS" : "FAIL") . " destination=" . $e->get("destination")
    . " format=" . ($dc["format"] ?? "none") . " menus=" . implode(",", $menus) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
