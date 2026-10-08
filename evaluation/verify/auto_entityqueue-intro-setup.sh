#!/usr/bin/env bash
# Introspection SETUP (auto_entityqueue): create entityqueue aeq_known targeting node/article
# with auto_entityqueue auto_add ON and insert_front ON. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\entityqueue\Entity\EntityQueue;
  if ($q = EntityQueue::load("aeq_known")) { $q->delete(); }
  EntityQueue::create([
    "id" => "aeq_known", "label" => "AEQ Known", "handler" => "simple",
    "entity_settings" => [
      "target_type" => "node", "handler" => "default",
      "handler_settings" => [
        "target_bundles" => ["article" => "article"],
        "auto_entityqueue" => ["auto_add" => TRUE, "insert_front" => TRUE],
      ],
    ],
    "queue_settings" => ["min_size" => 0, "max_size" => 0, "act_as_queue" => FALSE, "reverse" => FALSE],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: aeq_known target=node/article auto_add=true insert_front=true"
