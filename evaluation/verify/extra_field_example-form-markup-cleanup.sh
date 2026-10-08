#!/usr/bin/env bash
# Execution CLEANUP: strip the example form components and uninstall extra_field_example.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd) {
    foreach (["extra_field_example_markup", "extra_field_example_custom_submit"] as $n) { $fd->removeComponent($n); }
    $hidden = $fd->get("hidden") ?: [];
    foreach (array_keys($hidden) as $n) { if (str_starts_with($n, "extra_field_")) { unset($hidden[$n]); } }
    $fd->set("hidden", $hidden)->save();
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
echo "cleanup: extra_field_example uninstalled, node.article.default form display restored"
