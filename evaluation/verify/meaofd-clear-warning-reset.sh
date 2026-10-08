#!/usr/bin/env bash
# Execution RESET: inject a phantom base field (meaofd_h2_field) into node's last-installed definitions
# so the Status report shows the "Mismatched entity and/or field definitions" warning for node. verify
# FAILS until it is cleared. No real DB column is created. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Field\BaseFieldDefinition;
  $repo = \Drupal::service("entity.last_installed_schema.repository");
  $defs = $repo->getLastInstalledFieldStorageDefinitions("node");
  $defs["meaofd_h2_field"] = BaseFieldDefinition::create("string")
    ->setName("meaofd_h2_field")->setLabel("MEAOFD H2")
    ->setTargetEntityTypeId("node")->setProvider("node");
  $repo->setLastInstalledFieldStorageDefinitions("node", $defs);
  \Drupal::service("entity_type.manager")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "reset: Status report shows mismatched definitions warning for node (phantom meaofd_h2_field)"
