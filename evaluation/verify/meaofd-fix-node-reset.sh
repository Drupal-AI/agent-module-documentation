#!/usr/bin/env bash
# Execution RESET: inject a phantom base field (meaofd_h1_field) into node's last-installed definitions
# so the node entity type reports a mismatched definition. verify FAILS until the agent uses meaofd to
# reconcile node. No real DB column is created. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Field\BaseFieldDefinition;
  $repo = \Drupal::service("entity.last_installed_schema.repository");
  $defs = $repo->getLastInstalledFieldStorageDefinitions("node");
  $defs["meaofd_h1_field"] = BaseFieldDefinition::create("string")
    ->setName("meaofd_h1_field")->setLabel("MEAOFD H1")
    ->setTargetEntityTypeId("node")->setProvider("node");
  $repo->setLastInstalledFieldStorageDefinitions("node", $defs);
  \Drupal::service("entity_type.manager")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "reset: node reports a mismatched definition (phantom meaofd_h1_field)"
