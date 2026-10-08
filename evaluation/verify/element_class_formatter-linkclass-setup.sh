#!/usr/bin/env bash
# Introspection SETUP: create a link field on Article displayed with the link_class formatter and a
# known element class, so the agent can read the class back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ecf_link")) { FieldStorageConfig::create(["field_name"=>"field_ecf_link","entity_type"=>"node","type"=>"link"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_ecf_link")) { FieldConfig::create(["field_name"=>"field_ecf_link","entity_type"=>"node","bundle"=>"article","label"=>"ECF Link"])->save(); }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_ecf_link", ["type"=>"link_class","label"=>"hidden","weight"=>50,"region"=>"content","settings"=>["class"=>"btn btn-primary"]])->save();
' >/dev/null 2>&1
echo "setup: field_ecf_link uses link_class with class=btn btn-primary"
