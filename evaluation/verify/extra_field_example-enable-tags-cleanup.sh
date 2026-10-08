#!/usr/bin/env bash
# Execution CLEANUP: same as the reset. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall extra_field_example -y >/dev/null 2>&1
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd) {
    foreach (["extra_field_multilingual_field", "extra_field_formatted_field", "extra_field_article_only", "extra_field_all_nodes"] as $n) {
      $vd->removeComponent($n);
    }
    $hidden = $vd->get("hidden") ?: [];
    foreach (array_keys($hidden) as $n) { if (str_starts_with($n, "extra_field_")) { unset($hidden[$n]); } }
    $vd->set("hidden", $hidden)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: extra_field_example uninstalled, node.article.default restored"
