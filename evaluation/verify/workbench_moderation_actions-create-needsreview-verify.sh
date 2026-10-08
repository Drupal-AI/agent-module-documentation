#!/usr/bin/env bash
# Execution VERIFY: PASS when an 'action' config entity exists for the state_change node->
# needs_review derivative (plugin state_change:node__needs_review, applying to node). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\system\Entity\Action;
  $ok = FALSE;
  foreach (Action::loadMultiple() as $a) {
    if ((string) $a->get("plugin") === "state_change:node__needs_review") { $ok = TRUE; break; }
  }
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
