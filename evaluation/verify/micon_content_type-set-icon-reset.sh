#!/usr/bin/env bash
# Execution RESET: ensure content type micon_ct_task exists WITH NO Micon icon, so verify FAILs
# until the agent sets it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("micon_ct_task") ?: NodeType::create(["type"=>"micon_ct_task","name"=>"Micon CT Task"]);
  $t->unsetThirdPartySetting("micon_content_type","icon");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.type micon_ct_task present, no micon icon"
