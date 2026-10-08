#!/usr/bin/env bash
# Introspection CLEANUP: clear ultimenu.settings ajaxmw; delete the config object if it is otherwise
# empty. Restores baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  $c = $cf->getEditable("ultimenu.settings");
  if (!$c->isNew()) {
    $c->clear("ajaxmw");
    if (empty($c->get("blocks")) && empty($c->get("regions")) && empty($c->get("goodies")) && empty($c->get("ajaxmw"))) { $c->delete(); }
    else { $c->save(); }
  }
' >/dev/null 2>&1
echo "cleanup: ultimenu.settings ajaxmw cleared"
