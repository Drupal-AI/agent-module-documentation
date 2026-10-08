#!/usr/bin/env bash
# Execution VERIFY for the "create the upgrade_-prefixed d7_user migration" task.
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
# Checks that a migrate_plus migration config entity exists whose id applies migrate_upgrade's
# default `upgrade_` prefix to the core d7_user migration (id upgrade_d7_user) and that it is
# assigned to the migrate_drupal_7 migration group.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\migrate_plus\Entity\Migration;
  $m = Migration::load("upgrade_d7_user");
  $exists = (bool) $m;
  $prefixed = $exists && str_starts_with($m->id(), "upgrade_");
  $group = $exists ? (string) $m->get("migration_group") : "";
  $ok = $exists && $prefixed && $group === "migrate_drupal_7";
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($exists?1:0)
      . " prefixed=" . ($prefixed?1:0) . " group=" . $group . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
