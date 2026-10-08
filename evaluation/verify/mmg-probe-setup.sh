#!/usr/bin/env bash
# Introspection SETUP: enable monitoring_multigraph and create multigraph mg_probe aggregating two
# shipped sensors, with a known label, to read back. Baseline uninstalled; cleanup uninstalls. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install monitoring_multigraph -y >/dev/null 2>&1
drush php:eval '
  use Drupal\monitoring_multigraph\Entity\Multigraph;
  if ($m = Multigraph::load("mg_probe")) { $m->delete(); }
  Multigraph::create([
    "id" => "mg_probe", "label" => "MG Probe Label", "description" => "probe",
    "sensors" => [
      "core_cron_last_run_age" => ["weight" => 0, "label" => "Cron"],
      "system_load_average" => ["weight" => 1, "label" => "Load"],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: monitoring_multigraph enabled; multigraph mg_probe created"
