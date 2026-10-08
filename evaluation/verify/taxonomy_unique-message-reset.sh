#!/usr/bin/env bash
# Execution RESET: create/reset vocabulary tu_msg with taxonomy_unique disabled and no custom
# message, so verify FAILS until the agent enables uniqueness AND sets the required message.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("tu_msg") ?: Vocabulary::create(["vid" => "tu_msg", "name" => "TU Msg"]);
  $v->setThirdPartySetting("taxonomy_unique", "enabled", FALSE);
  $v->setThirdPartySetting("taxonomy_unique", "message", "");
  $v->save();
' >/dev/null 2>&1
echo "reset: vocabulary tu_msg present, uniqueness disabled, empty message"
