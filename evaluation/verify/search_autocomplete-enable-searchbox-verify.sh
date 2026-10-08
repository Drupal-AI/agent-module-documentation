#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled autocompletion_configuration targets selector #site-search.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("autocompletion_configuration");
$ok = FALSE;
foreach ($s->loadMultiple() as $e) {
  if ($e->getSelector() === "#site-search" && (bool) $e->getStatus() === TRUE) { $ok = TRUE; }
}
print ($ok ? "PASS" : "FAIL")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
