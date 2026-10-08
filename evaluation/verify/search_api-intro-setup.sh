#!/usr/bin/env bash
# Introspection SETUP: install a KNOWN Search API setup so an inspecting agent can read it back.
# Creates server `eval_intro_server` (Database backend, search_api_db) and index
# `eval_intro_index` (entity:node datasource) with two KNOWN indexed fields: title + body.
# Idempotent: deletes any prior eval_intro_* entities first. Only touches eval_intro_* — leaves
# any existing site search config (Solr/Pantheon) untouched. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $sm = \Drupal::entityTypeManager()->getStorage("search_api_server");
  $im = \Drupal::entityTypeManager()->getStorage("search_api_index");
  if ($i = $im->load("eval_intro_index")) { $i->delete(); }
  if ($s = $sm->load("eval_intro_server")) { $s->delete(); }
  $server = $sm->create([
    "id" => "eval_intro_server",
    "name" => "Eval Intro Server",
    "status" => TRUE,
    "backend" => "search_api_db",
    "backend_config" => ["database" => "default:default", "min_chars" => 1, "matching" => "words"],
  ]);
  $server->save();
  $index = $im->create([
    "id" => "eval_intro_index",
    "name" => "Eval Intro Index",
    "status" => TRUE,
    "datasource_settings" => ["entity:node" => []],
    "tracker_settings" => ["default" => []],
    "server" => "eval_intro_server",
  ]);
  $fh = \Drupal::getContainer()->get("search_api.fields_helper");
  $index->addField($fh->createField($index, "title", ["label"=>"Title","type"=>"string","datasource_id"=>"entity:node","property_path"=>"title"]));
  $index->addField($fh->createField($index, "body", ["label"=>"Body","type"=>"text","datasource_id"=>"entity:node","property_path"=>"body"]));
  $index->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: eval_intro_server (search_api_db) + eval_intro_index (entity:node, fields title+body) installed"
