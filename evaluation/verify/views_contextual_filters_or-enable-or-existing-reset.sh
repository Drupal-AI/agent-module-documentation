#!/usr/bin/env bash
# Reset the "enable OR on an existing view" execution baseline between eval runs so each
# condition is independent: (re)create the `vcfo_eval_toggle` view with TWO contextual
# filters (nid, uid) but the module's OR flag OFF (contextual_filters_or = FALSE). The
# agent must flip the flag ON. Idempotent: overwrites any prior copy. No arguments.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal\views\Entity\View::load("vcfo_eval_toggle")) { $v->delete(); }
  $view = \Drupal\views\Entity\View::create([
    "id" => "vcfo_eval_toggle",
    "label" => "VCFO Toggle",
    "base_table" => "node_field_data",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "query" => [
            "type" => "views_query",
            "options" => ["contextual_filters_or" => FALSE],
          ],
          "arguments" => [
            "nid" => ["id" => "nid", "table" => "node_field_data", "field" => "nid", "plugin_id" => "node_nid"],
            "uid" => ["id" => "uid", "table" => "node_field_data", "field" => "uid", "plugin_id" => "numeric"],
          ],
        ],
      ],
    ],
  ]);
  $view->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vcfo_eval_toggle created (2 contextual filters, contextual_filters_or = FALSE)"
