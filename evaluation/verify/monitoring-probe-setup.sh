#!/usr/bin/env bash
# Introspection SETUP: create a namespaced Monitoring sensor config 'mon_probe' (config_value plugin)
# with a known warning threshold (4242) so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\monitoring\Entity\SensorConfig;
  $s = SensorConfig::load("mon_probe");
  if (!$s) { $s = SensorConfig::create(["id" => "mon_probe"]); }
  $s->set("label", "Mon Probe");
  $s->set("plugin_id", "config_value");
  $s->set("category", "Custom");
  $s->set("value_type", "string");
  $s->set("status", TRUE);
  $s->set("thresholds", ["type" => "exceeds", "warning" => 4242, "critical" => 9999]);
  $s->set("settings", ["config" => "system.site", "key" => "name"]);
  $s->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: sensor mon_probe (config_value, warning=4242) created"
