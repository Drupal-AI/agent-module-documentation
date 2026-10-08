#!/usr/bin/env bash
# Execution VERIFY: PASS when an action config entity with plugin bibcite_export_multiple over
# bibcite_reference exists. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\system\Entity\Action;
  $ok = FALSE;
  foreach (Action::loadMultiple() as $a) {
    if ((string) $a->get("plugin") === "bibcite_export_multiple" && (string) $a->get("type") === "bibcite_reference") { $ok = TRUE; break; }
  }
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
