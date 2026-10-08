#!/usr/bin/env bash
# Execution CLEANUP: ensure the Trash workflow is present (re-import from the submodule).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Symfony\Component\Yaml\Yaml;
  if (\Drupal::config("workflows.workflow.workflow_buttons_trash_publishing")->isNew()) {
    $p = \Drupal::service("extension.list.module")->getPath("workflow_buttons_trash")."/config/install/workflows.workflow.workflow_buttons_trash_publishing.yml";
    $d = Yaml::parseFile(DRUPAL_ROOT."/".$p);
    \Drupal::configFactory()->getEditable("workflows.workflow.workflow_buttons_trash_publishing")->setData($d)->save(TRUE);
  }
' >/dev/null 2>&1
echo "cleanup: Trash workflow ensured present"
