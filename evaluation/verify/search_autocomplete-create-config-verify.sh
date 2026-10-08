#!/usr/bin/env bash
# Execution VERIFY: PASS when an autocompletion_configuration exists with selector #edit-keys,
# status enabled, and minChar 2. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("autocompletion_configuration");
$ok = FALSE;
foreach ($s->loadMultiple() as $e) {
  if ($e->getSelector() === "#edit-keys" && (bool) $e->getStatus() === TRUE && (int) $e->get("minChar") === 2) { $ok = TRUE; }
}
print ($ok ? "PASS" : "FAIL")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
