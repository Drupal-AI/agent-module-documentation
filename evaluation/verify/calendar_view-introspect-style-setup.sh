#!/usr/bin/env bash
# Introspection setup: install a KNOWN Calendar View using the WEEK style so the agent can
# read back which style plugin the display uses. Creates View `cv_eval_agenda` with the
# calendar_week style bound to the node `created` date field. Cleanup deletes it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $id = "cv_eval_agenda";
  if ($v = \Drupal\views\Entity\View::load($id)) { $v->delete(); }
  $view = \Drupal\views\Entity\View::create([
    "id" => $id,
    "label" => "CV Eval Agenda",
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
          "created" => [
            "id" => "created", "table" => "node_field_data", "field" => "created",
            "entity_type" => "node", "entity_field" => "created", "plugin_id" => "field",
          ],
        ],
        "style" => [
          "type" => "calendar_week",
          "options" => ["calendar_fields" => ["created" => "created"]],
        ],
        "row" => ["type" => "fields"],
      ],
    ],
  ]);
  $view->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view cv_eval_agenda (calendar_week bound to created) created"
