#!/usr/bin/env bash
# Introspection SETUP: create a heading field (field_hdg_known) on Article whose allowed_sizes
# is limited to h2 and h3, so an agent can read the constraint back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_hdg_known")) {
    FieldStorageConfig::create(["field_name"=>"field_hdg_known","entity_type"=>"node","type"=>"heading"])->save();
  }
  if ($fc = FieldConfig::loadByName("node","article","field_hdg_known")) { $fc->delete(); }
  FieldConfig::create([
    "field_name"=>"field_hdg_known","entity_type"=>"node","bundle"=>"article",
    "label"=>"Known Heading","settings"=>["label"=>"Title","allowed_sizes"=>["h2","h3"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_hdg_known (heading) allowed_sizes = h2, h3"
