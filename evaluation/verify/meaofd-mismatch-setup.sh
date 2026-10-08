#!/usr/bin/env bash
# Introspection SETUP: inject a phantom base field (meaofd_probe_field) into node's LAST-INSTALLED
# field-storage definitions only. This makes core report a "Mismatched entity and/or field
# definitions" condition for the node entity type (the field "needs to be uninstalled"), exactly what
# meaofd surfaces and fixes. No real DB column is created. Reversed by the matching cleanup (which runs
# meaofd's fixer). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Field\BaseFieldDefinition;
  $repo = \Drupal::service("entity.last_installed_schema.repository");
  $defs = $repo->getLastInstalledFieldStorageDefinitions("node");
  $defs["meaofd_probe_field"] = BaseFieldDefinition::create("string")
    ->setName("meaofd_probe_field")->setLabel("MEAOFD Probe")
    ->setTargetEntityTypeId("node")->setProvider("node");
  $repo->setLastInstalledFieldStorageDefinitions("node", $defs);
  \Drupal::service("entity_type.manager")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "setup: node reports a mismatched definition (phantom meaofd_probe_field needs uninstalling)"
