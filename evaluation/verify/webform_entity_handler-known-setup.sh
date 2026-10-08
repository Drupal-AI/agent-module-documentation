#!/usr/bin/env bash
# Introspection SETUP: create webform weh_known with a webform_entity_handler ("Entity")
# handler configured to CREATE a node:article. So an inspecting agent can read back the
# handler's target entity type and operation. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("weh_known")) { $w->delete(); }
  Webform::create(["id" => "weh_known", "title" => "WEH Known"])->save();
  $w = Webform::load("weh_known");
  $h = \Drupal::service("plugin.manager.webform.handler")->createInstance("webform_entity_handler", [
    "id" => "webform_entity_handler", "handler_id" => "weh_create_article", "label" => "Create Article",
    "status" => TRUE, "weight" => 0,
    "settings" => ["operation" => "_default", "entity_type_id" => "node:article", "entity_values" => [], "states" => ["completed"]],
  ]);
  $w->addWebformHandler($h);
  $w->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: webform weh_known has an Entity handler creating node:article (operation=_default)"
