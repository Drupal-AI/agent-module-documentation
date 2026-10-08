#!/usr/bin/env bash
# Introspection SETUP: create a non-default Advanced Queue queue config entity with a
# distinctive configuration (daemon processor, 600s lease time, 1000-item success-only
# cleanup threshold) so an agent can read it back off the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\advancedqueue\Entity\Queue;
  if ($q = Queue::load("advancedqueue_aq_reports")) { $q->delete(); }
  Queue::create([
    "id" => "advancedqueue_aq_reports",
    "label" => "AQ Reports",
    "backend" => "database",
    "backend_configuration" => ["lease_time" => 600],
    "processor" => "daemon",
    "processing_time" => 120,
    "locked" => TRUE,
    "stop_when_empty" => FALSE,
    "threshold" => ["type" => 1, "limit" => 1000, "state" => "success"],
  ])->save();
' >/dev/null 2>&1
echo "setup: advancedqueue.advancedqueue_queue.advancedqueue_aq_reports created (daemon, lease_time 600, locked)"
