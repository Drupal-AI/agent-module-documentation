#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure submodule enabled and NO me_template labeled 'ME Task Template'
# exists, so verify FAILS on empty state. Exit 0.
set -uo pipefail
cd /var/www/html
drush en mercury_editor_templates -y >/dev/null 2>&1
drush php:eval '  $s = \Drupal::entityTypeManager()->getStorage("me_template");
  foreach ($s->loadByProperties(["label" => "ME Task Template"]) as $e) { $e->delete(); }' >/dev/null 2>&1
echo "reset: no me_template 'ME Task Template'"
