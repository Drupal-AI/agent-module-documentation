#!/usr/bin/env bash
# Introspection CLEANUP: unplace the example pseudo-fields and uninstall extra_field_example.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  foreach (["node.page.default", "node.article.default"] as $id) {
    if ($d = $s->load($id)) {
      $d->removeComponent("extra_field_all_nodes");
      $hidden = $d->get("hidden") ?: [];
      foreach (array_keys($hidden) as $n) { if (str_starts_with($n, "extra_field_")) { unset($hidden[$n]); } }
      $d->set("hidden", $hidden)->save();
    }
  }
  $ud = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($ud) {
    $h = $ud->get("hidden") ?: [];
    unset($h["extra_field_example_custom_input"]);
    $ud->set("hidden", $h)->save();
  }
' >/dev/null 2>&1
drush pm:uninstall extra_field_example -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: extra_field_example uninstalled, node.page/node.article displays restored"
