#!/usr/bin/env bash
# Execution RESET: force Layout Builder OFF on node.page.default and remove the
# layout_builder__translation field so verify FAILS until the agent enables overrides.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  if ($d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.page.default")) {
    $d->disableLayoutBuilder()->setOverridable(FALSE)->save();
  }
  foreach (["layout_builder__translation","layout_builder__layout"] as $fn) {
    if ($fc = FieldConfig::loadByName("node","page",$fn)) { $fc->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.page LB overrides OFF; layout_builder__translation absent"
