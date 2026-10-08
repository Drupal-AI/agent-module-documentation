#!/usr/bin/env bash
# Execution RESET: (re)create a namespaced View 'tome_ssc_probe' whose default display uses the
# core 'none' cache plugin, so verify FAILS until the agent switches it to the Tome Static Super
# Cache 'Smart tag based' plugin. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $s->load("tome_ssc_probe")) { $v->delete(); }
  \Drupal\views\Entity\View::create([
    "id" => "tome_ssc_probe",
    "label" => "Tome SSC Probe",
    "base_table" => "node_field_data",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => ["cache" => ["type" => "none", "options" => []]],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view tome_ssc_probe created with cache type = none"
