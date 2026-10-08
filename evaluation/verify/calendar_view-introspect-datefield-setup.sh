#!/usr/bin/env bash
# Introspection setup: install a KNOWN Calendar View so the agent can read it back.
# Creates View `cv_eval_events` whose display uses the calendar_month style bound to the
# node `changed` date field (via calendar_fields). Cleanup deletes it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $id = "cv_eval_events";
  if ($v = \Drupal\views\Entity\View::load($id)) { $v->delete(); }
  $view = \Drupal\views\Entity\View::create([
    "id" => $id,
    "label" => "CV Eval Events",
    "base_table" => "node_field_data",
    "base_field" => "nid",
  ]);
  $view->set("display", [
    "default" => [
      "id" => "default",
      "display_title" => "Default",
      "display_plugin" => "default",
      "position" => 0,
      "display_options" => [
        "fields" => [
          "changed" => [
            "id" => "changed", "table" => "node_field_data", "field" => "changed",
            "entity_type" => "node", "entity_field" => "changed", "plugin_id" => "field",
          ],
        ],
        "style" => [
          "type" => "calendar_month",
          "options" => ["calendar_fields" => ["changed" => "changed"]],
        ],
        "row" => ["type" => "fields"],
      ],
    ],
  ]);
  $view->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view cv_eval_events (calendar_month bound to changed) created"
