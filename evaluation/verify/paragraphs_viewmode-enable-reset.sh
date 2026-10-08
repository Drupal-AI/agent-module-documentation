#!/usr/bin/env bash
# Execution RESET: ensure paragraph type pvm_task exists with NO paragraphs_viewmode_behavior
# (behavior_plugins empty) so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  if (!ParagraphsType::load("pvm_task")) {
    ParagraphsType::create(["id"=>"pvm_task","label"=>"PVM Task"])->save();
  }
  $pt = ParagraphsType::load("pvm_task");
  $pt->set("behavior_plugins", []);
  $pt->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: paragraphs_type pvm_task present with no behavior plugins"
