#!/usr/bin/env bash
# Execution RESET: ensure field_micon_pkg exists on Article with a string_micon widget offering
# ALL packages (settings.packages = []), so verify FAILs until the agent restricts it to `fa`.
# Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_micon_pkg")) {
    FieldStorageConfig::create(["field_name"=>"field_micon_pkg","entity_type"=>"node","type"=>"string_micon"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_micon_pkg")) {
    FieldConfig::create(["field_name"=>"field_micon_pkg","entity_type"=>"node","bundle"=>"article","label"=>"Package Icon"])->save();
  }
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $fd->setComponent("field_micon_pkg", ["type"=>"string_micon","weight"=>51,"region"=>"content","settings"=>["packages"=>[]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_micon_pkg present, widget packages=[] (all)"
