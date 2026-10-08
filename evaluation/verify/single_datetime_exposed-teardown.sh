#!/usr/bin/env bash
# Shared CLEANUP for the single_datetime_exposed evals: delete every sdt_exp_* View config this
# submodule's setup/reset scripts create. Written with the raw config factory (NOT the Views
# entity API) so it works even though an unrelated contrib module currently fatals Views filter
# plugin discovery on this shared site. Only touches this submodule's namespaced views. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  foreach ($cf->listAll("views.view.sdt_exp_") as $name) {
    $cf->getEditable($name)->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sdt_exp_* views removed"
