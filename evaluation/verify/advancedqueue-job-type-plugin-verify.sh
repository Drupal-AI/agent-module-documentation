#!/usr/bin/env bash
# Execution VERIFY for the job type plugin case. PASS when:
#   * the advancedqueue_job_type plugin advancedqueue_eval_uppercase is discoverable with
#     max_retries 2 and retry_delay 30;
#   * the advancedqueue_eval_queue queue exists using the database backend;
#   * that queue holds a job of that type in the 'success' state whose stored message is
#     "HELLO QUEUE" (i.e. the job was really enqueued AND really processed).
# exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\advancedqueue\Entity\Queue;
  $checks = [];
  $manager = \Drupal::service("plugin.manager.advancedqueue_job_type");
  $def = $manager->hasDefinition("advancedqueue_eval_uppercase")
    ? $manager->getDefinition("advancedqueue_eval_uppercase") : NULL;
  $checks["plugin_exists"] = (bool) $def;
  $checks["max_retries"] = $def && (int) ($def["max_retries"] ?? -1) === 2;
  $checks["retry_delay"] = $def && (int) ($def["retry_delay"] ?? -1) === 30;
  $q = Queue::load("advancedqueue_eval_queue");
  $checks["queue_exists"] = (bool) $q;
  $checks["queue_backend"] = $q && $q->getBackendId() === "database";
  $row = \Drupal::database()->select("advancedqueue", "a")
    ->fields("a", ["state", "message", "type"])
    ->condition("queue_id", "advancedqueue_eval_queue")
    ->condition("type", "advancedqueue_eval_uppercase")
    ->orderBy("job_id", "DESC")
    ->range(0, 1)
    ->execute()->fetchAssoc();
  $checks["job_present"] = (bool) $row;
  $checks["job_success"] = $row && $row["state"] === "success";
  $checks["job_message"] = $row && trim((string) $row["message"]) === "HELLO QUEUE";
  $bad = array_keys(array_filter($checks, fn ($v) => !$v));
  print ($bad ? "FAIL wrong=" . implode(",", $bad) : "PASS")
    . " def=" . json_encode($def ? array_intersect_key($def, array_flip(["id", "max_retries", "retry_delay"])) : NULL)
    . " job=" . json_encode($row) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
