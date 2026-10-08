#!/usr/bin/env bash
# Execution CLEANUP: remove any autocompletion_configuration targeting #edit-keys. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("autocompletion_configuration");
foreach ($s->loadMultiple() as $e) { if ($e->getSelector() === "#edit-keys") $e->delete(); }
if ($e = $s->load("sa_task")) $e->delete();
' >/dev/null 2>&1
echo "cleanup: #edit-keys autocompletion configs removed"
