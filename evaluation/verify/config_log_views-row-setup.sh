#!/usr/bin/env bash
# Introspection SETUP: insert a known row into the config_log table that the Config Log Views
# report surfaces, so the agent can read back the logged config name. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  if ($db->schema()->tableExists("config_log")) {
    $db->delete("config_log")->condition("name", "clv_eval_marker.settings")->execute();
    $db->insert("config_log")->fields([
      "uid" => 1, "operation" => "update", "name" => "clv_eval_marker.settings",
      "data" => "foo: bar\n", "originaldata" => "foo: baz\n",
      "created" => \Drupal::time()->getRequestTime(),
    ])->execute();
  }
' >/dev/null 2>&1
echo "setup: config_log row name=clv_eval_marker.settings inserted"
