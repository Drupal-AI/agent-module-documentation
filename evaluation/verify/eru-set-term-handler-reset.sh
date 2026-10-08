#!/usr/bin/env bash
# reset: field_eru_vocab handler=default:taxonomy_term (published only)
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_eru_vocab")) {
    FieldStorageConfig::create(["field_name"=>"field_eru_vocab","entity_type"=>"node","type"=>"entity_reference","cardinality"=>1,"settings"=>["target_type"=>"taxonomy_term"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_eru_vocab")) {
    FieldConfig::create(["field_name"=>"field_eru_vocab","entity_type"=>"node","bundle"=>"article","label"=>"ERU Vocab","settings"=>["handler"=>"default:taxonomy_term","handler_settings"=>[]]])->save();
  } else {
    $fc=FieldConfig::loadByName("node","article","field_eru_vocab"); $fc->setSetting("handler","default:taxonomy_term")->setSetting("handler_settings",[])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_eru_vocab handler=default:taxonomy_term (published only)"
