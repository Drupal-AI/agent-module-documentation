#!/usr/bin/env bash
# Execution CLEANUP: restore gin_lb.settings from the snapshot taken by the matching reset
# (falling back to the module's shipped defaults) and drop the state key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $state = \Drupal::state();
  $backup = $state->get("gin_lb_eval.buttons_backup");
  if (!\is_array($backup) || empty($backup)) {
    $path = \Drupal::service("extension.list.module")->getPath("gin_lb") . "/config/install/gin_lb.settings.yml";
    $backup = \Symfony\Component\Yaml\Yaml::parse(\file_get_contents($path));
  }
  $c = \Drupal::configFactory()->getEditable("gin_lb.settings");
  foreach ($backup as $k => $v) { $c->set($k, $v); }
  $c->save();
  $state->delete("gin_lb_eval.buttons_backup");
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: gin_lb.settings restored from snapshot"
