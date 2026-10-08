#!/usr/bin/env bash
# Execution VERIFY: PASS when a dashboard labeled 'Team Home' exists with frontend === TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("dashboard");
$ok = FALSE;
foreach ($s->loadMultiple() as $d) {
  if ($d->label() === "Team Home" && (bool) $d->get("frontend") === TRUE) { $ok = TRUE; }
}
print ($ok ? "PASS" : "FAIL")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
