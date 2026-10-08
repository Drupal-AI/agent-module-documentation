#!/usr/bin/env bash
# Execution CLEANUP: remove field_ltgt_task from ltgt_ct, then delete the ltgt_ct fixture
# content type entirely once no other link_target eval fields reference it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\node\Entity\NodeType;

  if ($fc = FieldConfig::loadByName("node", "ltgt_ct", "field_ltgt_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ltgt_task")) { $fs->delete(); }

  $all = \Drupal::entityTypeManager()->getStorage("field_config")
    ->loadByProperties(["entity_type" => "node", "bundle" => "ltgt_ct"]);
  $remaining = array_filter($all, function ($fc) { return strpos($fc->getName(), "field_ltgt_") === 0; });
  if (empty($remaining) && ($nt = NodeType::load("ltgt_ct"))) { $nt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ltgt_task removed; ltgt_ct removed if no other fixture fields remained"
