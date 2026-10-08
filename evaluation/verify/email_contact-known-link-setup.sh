#!/usr/bin/env bash
# Introspection SETUP: add email field field_ec_known to Article and set its default view
# display formatter to email_contact_link with link_text "Reach the author" and modal on, so
# the agent can read which formatter/link text is configured. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ec_known")) { FieldStorageConfig::create(["field_name"=>"field_ec_known","entity_type"=>"node","type"=>"email"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_ec_known")) { FieldConfig::create(["field_name"=>"field_ec_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Email"])->save(); }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ec_known", ["type"=>"email_contact_link","label"=>"hidden","weight"=>50,"settings"=>["link_text"=>"Reach the author","modal"=>TRUE,"title"=>"","include_values"=>1,"default_message"=>""]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ec_known uses email_contact_link, link_text=Reach the author"
