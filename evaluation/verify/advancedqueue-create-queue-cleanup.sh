#!/usr/bin/env bash
# Execution CLEANUP: same as reset - remove the advancedqueue_nightly queue and its jobs.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\advancedqueue\Entity\Queue;
  \Drupal::database()->delete("advancedqueue")->condition("queue_id", "advancedqueue_nightly")->execute();
  if ($q = Queue::load("advancedqueue_nightly")) { $q->delete(); }
' >/dev/null 2>&1
echo "cleanup: advancedqueue_nightly queue removed"
