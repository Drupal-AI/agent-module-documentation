#!/usr/bin/env bash
# Introspection CLEANUP: remove the pvm_prev paragraph type, its form display and the
# paragraph_view_mode field created by the matching setup. Restores baseline. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  \Drupal::service("paragraph_view_mode.storage_manager")->deleteField("pvm_prev");
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("paragraph.pvm_prev.default");
  if ($fd) { $fd->delete(); }
  if ($pt = ParagraphsType::load("pvm_prev")) { $pt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pvm_prev paragraph type removed"
