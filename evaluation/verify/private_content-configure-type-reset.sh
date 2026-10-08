#!/usr/bin/env bash
# Execution RESET: ensure content type pc_task exists and is NOT always-private (mode 1,
# public-by-default) so verify FAILS until the agent sets always-private. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("pc_task") ?: NodeType::create(["type"=>"pc_task","name"=>"PC Task"]);
  if ($t->isNew()) { $t->save(); $t = NodeType::load("pc_task"); }
  $t->setThirdPartySetting("private_content","private",1);
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: content type pc_task present with private_content.private=1 (public by default)"
