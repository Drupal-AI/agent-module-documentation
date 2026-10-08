#!/usr/bin/env bash
# Introspection CLEANUP: remove the custom role, unregister the group and delete the probe node
# type. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\og\Og;
  use Drupal\og\Entity\OgRole;
  if ($editor = OgRole::load("node-ogui_grp-editor")) { $editor->delete(); }
  $membership_storage = \Drupal::entityTypeManager()->getStorage("og_membership");
  $ids = $membership_storage->getQuery()->accessCheck(FALSE)
    ->condition("entity_type", "node")
    ->condition("entity_bundle", "ogui_grp")
    ->execute();
  if ($ids) { $membership_storage->delete($membership_storage->loadMultiple($ids)); }
  if (Og::isGroup("node", "ogui_grp")) { Og::groupTypeManager()->removeGroup("node", "ogui_grp"); }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach ($storage->loadByProperties(["type" => "ogui_grp"]) as $node) { $node->delete(); }
  if ($nt = NodeType::load("ogui_grp")) { $nt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ogui_grp group type, its OG roles and nodes removed"
