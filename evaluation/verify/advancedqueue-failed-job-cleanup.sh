#!/usr/bin/env bash
# Introspection CLEANUP: drop the seeded jobs and the AQ Audit queue.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\advancedqueue\Entity\Queue;
  \Drupal::database()->delete("advancedqueue")->condition("queue_id", "advancedqueue_aq_audit")->execute();
  if ($q = Queue::load("advancedqueue_aq_audit")) { $q->delete(); }
' >/dev/null 2>&1
echo "cleanup: advancedqueue_aq_audit queue and its jobs removed"
