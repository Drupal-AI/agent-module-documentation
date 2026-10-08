#!/usr/bin/env bash
# Execution RESET: delete the advancedqueue_nightly queue config entity (and any of its
# jobs) so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\advancedqueue\Entity\Queue;
  \Drupal::database()->delete("advancedqueue")->condition("queue_id", "advancedqueue_nightly")->execute();
  if ($q = Queue::load("advancedqueue_nightly")) { $q->delete(); print "deleted\n"; }
  else { print "absent\n"; }
' 2>/dev/null | tail -1
echo "reset: advancedqueue_nightly queue does not exist"
