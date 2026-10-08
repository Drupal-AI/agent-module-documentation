#!/usr/bin/env bash
# Execution RESET: ensure the examples' 'contributor' node form mode exists (submodule enabled)
# but is NOT activated on the Article bundle (delete entity_form_display node.article.contributor)
# so verify FAILS until the agent activates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en form_mode_manager_examples -y >/dev/null 2>&1
drush php:eval '
  if ($d = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.contributor")) { $d->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: examples contributor form mode present, NOT activated on node.article"
