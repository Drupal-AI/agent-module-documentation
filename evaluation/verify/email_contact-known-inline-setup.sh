#!/usr/bin/env bash
# Introspection SETUP: add email field field_ec_inline to Article, display formatter
# email_contact_inline with redirection_to=front. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ec_inline")) { FieldStorageConfig::create(["field_name"=>"field_ec_inline","entity_type"=>"node","type"=>"email"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_ec_inline")) { FieldConfig::create(["field_name"=>"field_ec_inline","entity_type"=>"node","bundle"=>"article","label"=>"Inline Email"])->save(); }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ec_inline", ["type"=>"email_contact_inline","label"=>"hidden","weight"=>51,"settings"=>["redirection_to"=>"front","custom_path"=>"","include_values"=>1,"default_message"=>""]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ec_inline uses email_contact_inline, redirection_to=front"
