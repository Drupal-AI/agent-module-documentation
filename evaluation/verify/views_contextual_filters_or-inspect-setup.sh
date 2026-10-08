#!/usr/bin/env bash
# Introspection SETUP: install a KNOWN view whose contextual filters are configured for
# OR so an inspecting agent can read it back via drush. Creates view `vcfo_eval_known`
# (base node_field_data) with a default display that has TWO contextual filters (nid, uid)
# and the module's query option contextual_filters_or = TRUE. Idempotent: deletes any
# prior copy first. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal\views\Entity\View::load("vcfo_eval_known")) { $v->delete(); }
  $view = \Drupal\views\Entity\View::create([
    "id" => "vcfo_eval_known",
    "label" => "VCFO Known",
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
            "options" => ["contextual_filters_or" => TRUE],
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
echo "setup: view vcfo_eval_known installed (contextual filters nid+uid, contextual_filters_or = TRUE)"
