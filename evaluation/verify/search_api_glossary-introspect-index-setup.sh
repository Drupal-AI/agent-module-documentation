#!/usr/bin/env bash
# Introspection SETUP: ensure a Search API index sag_glossary_index exists WITH the glossary
# processor enabled, so an agent can find which index uses it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  use Drupal\search_api\Entity\Index;
  if (!Server::load("sag_glossary_server")) {
    Server::create(["id" => "sag_glossary_server", "name" => "SAG Glossary Server", "status" => 1, "backend" => "search_api_db", "backend_config" => ["database" => "default:default", "min_chars" => 3]])->save();
  }
  if (!Index::load("sag_glossary_index")) {
    Index::create(["id" => "sag_glossary_index", "name" => "SAG Glossary Index", "status" => 1, "datasource_settings" => ["entity:node" => []], "tracker_settings" => ["default" => []], "server" => "sag_glossary_server"])->save();
  }
  $i = Index::load("sag_glossary_index");
  if (!$i->isValidProcessor("glossary")) {
    $p = \Drupal::service("plugin.manager.search_api.processor")->createInstance("glossary", ["#index" => $i]);
    $i->addProcessor($p); $i->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: sag_glossary_index has glossary processor enabled"
