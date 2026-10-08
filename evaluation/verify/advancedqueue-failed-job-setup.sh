#!/usr/bin/env bash
# Introspection SETUP: create the AQ Audit queue and seed the advancedqueue table with three
# jobs - two in the success state and one in the failure state carrying a distinctive
# message. Rows are written straight to storage so no custom job type plugin is required.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\advancedqueue\Entity\Queue;
  if (!Queue::load("advancedqueue_aq_audit")) {
    Queue::create([
      "id" => "advancedqueue_aq_audit",
      "label" => "AQ Audit",
      "backend" => "database",
      "backend_configuration" => ["lease_time" => 300],
      "processor" => "cron",
      "processing_time" => 90,
      "locked" => FALSE,
      "stop_when_empty" => TRUE,
      "threshold" => ["type" => 0, "limit" => 0, "state" => "all"],
    ])->save();
  }
  $db = \Drupal::database();
  $db->delete("advancedqueue")->condition("queue_id", "advancedqueue_aq_audit")->execute();
  $now = \Drupal::time()->getRequestTime();
  $rows = [
    ["state" => "success", "message" => "AQ audit export finished", "num_retries" => 0],
    ["state" => "success", "message" => "AQ audit export finished", "num_retries" => 0],
    ["state" => "failure", "message" => "AQ payment gateway timed out", "num_retries" => 3],
  ];
  foreach ($rows as $row) {
    $db->insert("advancedqueue")->fields([
      "queue_id" => "advancedqueue_aq_audit",
      "type" => "advancedqueue_aq_export",
      "payload" => json_encode(["report" => "monthly"]),
      "state" => $row["state"],
      "message" => $row["message"],
      "num_retries" => $row["num_retries"],
      "available" => $now,
      "processed" => $now,
      "expires" => 0,
      "fingerprint" => NULL,
    ])->execute();
  }
' >/dev/null 2>&1
echo "setup: advancedqueue_aq_audit queue seeded with 2 success + 1 failure job"
