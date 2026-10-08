#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped permissions_by_term.settings defaults and delete the
# pbt_lock_vocab vocabulary. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  \Drupal::configFactory()->getEditable("permissions_by_term.settings")
    ->set("permission_mode", FALSE)
    ->set("require_all_terms_granted", FALSE)
    ->set("disable_node_access_records", FALSE)
    ->set("target_bundles", [])
    ->set("show_terms_in_user_form", TRUE)
    ->set("hide_terms_permissions_info_in_node_form", FALSE)
    ->save();
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach ($storage->loadByProperties(["vid" => "pbt_lock_vocab"]) as $term) { $term->delete(); }
  if ($v = Vocabulary::load("pbt_lock_vocab")) { $v->delete(); }
  print json_encode(\Drupal::config("permissions_by_term.settings")->getRawData()) . "\n";
' 2>/dev/null
echo "cleanup: settings restored, pbt_lock_vocab removed"
