#!/usr/bin/env bash
# Introspection SETUP: build a namespaced Search API index (satmn_index, DISABLED) with a
# taxonomy term machine_name field and ENABLE the search_api_taxonomy_machine_name
# 'taxonomy_machine_name_hierarchy' processor on it, so an agent can inspect the live index and
# report that the machine-name hierarchy processor is enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\search_api\Entity\Server;
  use Drupal\search_api\Entity\Index;
  use Drupal\search_api\Item\Field as SapiField;
  if (!FieldStorageConfig::loadByName("node","field_satmn_cat")) { FieldStorageConfig::create(["field_name"=>"field_satmn_cat","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"taxonomy_term"]])->save(); }
  if (!FieldConfig::loadByName("node","article","field_satmn_cat")) { FieldConfig::create(["field_name"=>"field_satmn_cat","entity_type"=>"node","bundle"=>"article","label"=>"SATMN Category","settings"=>["handler"=>"default:taxonomy_term","handler_settings"=>["target_bundles"=>["tags"=>"tags"]]]])->save(); }
  if (!Server::load("satmn_server")) { Server::create(["id"=>"satmn_server","name"=>"SATMN Server","status"=>TRUE,"backend"=>"search_api_db","backend_config"=>["min_chars"=>3,"database"=>"default:default"]])->save(); }
  if (!Index::load("satmn_index")) { Index::create(["id"=>"satmn_index","name"=>"SATMN Index","status"=>FALSE,"server"=>"satmn_server","datasource_settings"=>["entity:node"=>[]]])->save(); }
  $i=Index::load("satmn_index");
  if (!$i->getField("field_satmn_cat_machine_name")) {
    $f=new SapiField($i,"field_satmn_cat_machine_name");
    $f->setType("string")->setDatasourceId("entity:node")->setPropertyPath("field_satmn_cat:entity:machine_name")->setLabel("Category machine name");
    $i->addField($f); $i->save();
  }
  $i=Index::load("satmn_index");
  if (!in_array("taxonomy_machine_name_hierarchy", array_keys($i->getProcessors()))) {
    $pm=\Drupal::service("plugin.manager.search_api.processor");
    $proc=$pm->createInstance("taxonomy_machine_name_hierarchy",["#index"=>$i,"fields"=>["field_satmn_cat_machine_name"=>["status"=>TRUE]]]);
    $i->addProcessor($proc); $i->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: satmn_index has taxonomy_machine_name_hierarchy processor enabled for field_satmn_cat_machine_name"
