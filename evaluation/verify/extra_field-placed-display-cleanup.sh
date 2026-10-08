#!/usr/bin/env bash
# Introspection CLEANUP: remove the extra_field components from the Article view display and
# the user form display, then uninstall extra_field_example. Restores baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  foreach (["extra_field_formatted_field", "extra_field_all_nodes", "extra_field_article_only", "extra_field_multilingual_field"] as $n) {
    $vd->removeComponent($n);
  }
  $c = $vd->toArray();
  foreach (array_keys($c["hidden"] ?? []) as $n) {
    if (str_starts_with($n, "extra_field_")) { $vd->set("hidden", array_diff_key($vd->get("hidden"), [$n => TRUE])); }
  }
  $vd->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($fd) {
    $hidden = $fd->get("hidden") ?: [];
    unset($hidden["extra_field_example_custom_input"]);
    $fd->set("hidden", $hidden)->save();
  }
' >/dev/null 2>&1
drush pm:uninstall extra_field_example -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: extra_field_example uninstalled and its display components removed"
