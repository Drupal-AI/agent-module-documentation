#!/usr/bin/env bash
# Introspection CLEANUP: remove the pvm_known / pvm_plain paragraph types, their form displays
# and the paragraph_view_mode field created by the matching setup. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  $sm = \Drupal::service("paragraph_view_mode.storage_manager");
  foreach (["pvm_known", "pvm_plain"] as $id) {
    $sm->deleteField($id);
    foreach (["default"] as $mode) {
      $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("paragraph." . $id . "." . $mode);
      if ($fd) { $fd->delete(); }
    }
    if ($pt = ParagraphsType::load($id)) { $pt->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pvm_known and pvm_plain paragraph types removed"
