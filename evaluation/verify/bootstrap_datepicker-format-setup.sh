#!/usr/bin/env bash
# Introspection SETUP: create a datetime field field_bsd_fmt on Article using the
# bootstrap_date_widget with settings.format='dd/mm/yyyy', so the agent can read the configured
# date format back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_bsd_fmt")) {
    FieldStorageConfig::create(["field_name"=>"field_bsd_fmt","entity_type"=>"node","type"=>"datetime","settings"=>["datetime_type"=>"datetime"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_bsd_fmt")) {
    FieldConfig::create(["field_name"=>"field_bsd_fmt","entity_type"=>"node","bundle"=>"article","label"=>"BSD Fmt"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bsd_fmt", ["type"=>"bootstrap_date_widget","weight"=>52,"region"=>"content","settings"=>["format"=>"dd/mm/yyyy"]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_bsd_fmt uses bootstrap_date_widget with format=dd/mm/yyyy"
