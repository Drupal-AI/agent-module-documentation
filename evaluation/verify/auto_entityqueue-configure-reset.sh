#!/usr/bin/env bash
# Execution RESET (auto_entityqueue): (re)create entityqueue aeq_task targeting node/article
# with auto_entityqueue auto_add OFF and insert_front OFF, so both verify scripts FAIL until the
# agent enables auto-add. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\entityqueue\Entity\EntityQueue;
  if ($q = EntityQueue::load("aeq_task")) { $q->delete(); }
  EntityQueue::create([
    "id" => "aeq_task", "label" => "AEQ Task", "handler" => "simple",
    "entity_settings" => [
      "target_type" => "node", "handler" => "default",
      "handler_settings" => [
        "target_bundles" => ["article" => "article"],
        "auto_entityqueue" => ["auto_add" => FALSE, "insert_front" => FALSE],
      ],
    ],
    "queue_settings" => ["min_size" => 0, "max_size" => 0, "act_as_queue" => FALSE, "reverse" => FALSE],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: aeq_task auto_add=false insert_front=false"
