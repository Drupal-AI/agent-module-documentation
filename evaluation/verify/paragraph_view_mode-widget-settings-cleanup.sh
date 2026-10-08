#!/usr/bin/env bash
# Execution CLEANUP: remove the pvm_cfg paragraph type, its displays, the paragraph_view_mode
# field and the pvm_teaser paragraph view mode created by the matching reset. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\Core\Entity\Entity\EntityViewMode;
  \Drupal::service("paragraph_view_mode.storage_manager")->deleteField("pvm_cfg");
  foreach (["entity_form_display" => ["paragraph.pvm_cfg.default"],
            "entity_view_display" => ["paragraph.pvm_cfg.pvm_teaser", "paragraph.pvm_cfg.default"]] as $et => $ids) {
    foreach ($ids as $id) {
      $d = \Drupal::entityTypeManager()->getStorage($et)->load($id);
      if ($d) { $d->delete(); }
    }
  }
  if ($pt = ParagraphsType::load("pvm_cfg")) { $pt->delete(); }
  if ($vm = EntityViewMode::load("paragraph.pvm_teaser")) { $vm->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pvm_cfg paragraph type and pvm_teaser view mode removed"
