#!/usr/bin/env bash
# Execution CLEANUP: remove any autocompletion_configuration targeting #site-search. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("autocompletion_configuration");
foreach ($s->loadMultiple() as $e) { if ($e->getSelector() === "#site-search") $e->delete(); }
if ($e = $s->load("sa_owner")) $e->delete();
' >/dev/null 2>&1
echo "cleanup: #site-search autocompletion configs removed"
