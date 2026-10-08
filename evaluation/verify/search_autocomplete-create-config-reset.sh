#!/usr/bin/env bash
# Execution RESET: remove any autocompletion_configuration targeting selector #edit-keys (so verify
# FAILS until the agent creates it). Leaves the shipped configs intact. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("autocompletion_configuration");
foreach ($s->loadMultiple() as $e) { if ($e->getSelector() === "#edit-keys") $e->delete(); }
if ($e = $s->load("sa_task")) $e->delete();
' >/dev/null 2>&1
echo "reset: no autocompletion_configuration targets #edit-keys"
