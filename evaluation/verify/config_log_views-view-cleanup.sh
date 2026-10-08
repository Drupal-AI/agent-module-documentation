#!/usr/bin/env bash
# Execution CLEANUP: ensure the config_log report view is present (re-import from the submodule).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Symfony\Component\Yaml\Yaml;
  if (\Drupal::config("views.view.config_log")->isNew()) {
    $p = \Drupal::service("extension.list.module")->getPath("config_log_views")."/config/install/views.view.config_log.yml";
    $d = Yaml::parseFile(DRUPAL_ROOT."/".$p);
    \Drupal::configFactory()->getEditable("views.view.config_log")->setData($d)->save(TRUE);
  }
' >/dev/null 2>&1
echo "cleanup: views.view.config_log ensured present"
