#!/usr/bin/env bash
# Execution VERIFY for the "create the configure-only migration group" task.
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
# Checks that a migrate_plus migration_group config entity migrate_drupal_7 exists and
# declares the source connection key drupal_7 (matching what migrate:upgrade --configure-only
# generates for a Drupal 7 source).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\migrate_plus\Entity\MigrationGroup;
  $g = MigrationGroup::load("migrate_drupal_7");
  $exists = (bool) $g;
  $key = "";
  if ($g) {
    $shared = $g->get("shared_configuration") ?: [];
    $key = $shared["source"]["key"] ?? "";
  }
  $ok = $exists && $key === "drupal_7";
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($exists?1:0) . " key=" . $key . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
