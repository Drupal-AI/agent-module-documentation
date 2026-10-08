#!/usr/bin/env bash
# Execution RESET: (re)create webform weh_retarget with an Entity handler currently targeting
# node:article, so verify (wants node:page) FAILS until the agent retargets it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("weh_retarget")) { $w->delete(); }
  Webform::create(["id" => "weh_retarget", "title" => "WEH Retarget"])->save();
  $w = Webform::load("weh_retarget");
  $h = \Drupal::service("plugin.manager.webform.handler")->createInstance("webform_entity_handler", [
    "id" => "webform_entity_handler", "handler_id" => "weh_map", "label" => "Entity",
    "status" => TRUE, "weight" => 0,
    "settings" => ["operation" => "_default", "entity_type_id" => "node:article", "entity_values" => [], "states" => ["completed"]],
  ]);
  $w->addWebformHandler($h);
  $w->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: webform weh_retarget Entity handler targets node:article"
