#!/usr/bin/env bash
# Execution RESET: create/reset vocabulary tu_task with taxonomy_unique DISABLED, so verify
# FAILS until the agent enables uniqueness on it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("tu_task") ?: Vocabulary::create(["vid" => "tu_task", "name" => "TU Task"]);
  $v->setThirdPartySetting("taxonomy_unique", "enabled", FALSE);
  $v->save();
' >/dev/null 2>&1
echo "reset: vocabulary tu_task present with taxonomy_unique.enabled=FALSE"
