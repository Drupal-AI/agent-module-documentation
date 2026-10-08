#!/usr/bin/env bash
# Execution RESET/CLEANUP: (re)create vocabulary vdl_edit with a SHORT one-line description, so
# the "give it a long description" task is not already satisfied (verify FAILS). Raw config
# write. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $existing = \Drupal::config("taxonomy.vocabulary.vdl_edit")->get("uuid");
  \Drupal::configFactory()->getEditable("taxonomy.vocabulary.vdl_edit")->setData([
    "langcode"=>"en","status"=>true,"dependencies"=>[],"name"=>"VDL Edit","vid"=>"vdl_edit",
    "weight"=>0,"new_revision"=>false,"description"=>"Short.",
    "uuid"=>$existing ?: \Drupal::service("uuid")->generate(),
  ])->save();
' >/dev/null 2>&1
echo "reset: vocabulary vdl_edit present with a short description"
