#!/usr/bin/env bash
# Execution RESET: ensure vocabulary nodeorder_hard exists and is NOT orderable (so verify FAILS
# until the agent makes it orderable). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  if (!Vocabulary::load("nodeorder_hard")) { Vocabulary::create(["vid"=>"nodeorder_hard","name"=>"NodeOrder Hard"])->save(); }
  \Drupal::service("nodeorder.config_manager")->updateOrderableValue("nodeorder_hard", FALSE);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vocabulary nodeorder_hard present and NOT orderable"
