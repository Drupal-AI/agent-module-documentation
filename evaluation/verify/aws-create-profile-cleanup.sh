#!/usr/bin/env bash
# Execution CLEANUP: delete any eu-central-1 default profile the agent created, plus aws_task_profile.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("aws_profile");
  foreach ($s->loadMultiple() as $p) {
    if ($p->id() === "aws_task_profile" || ($p->getRegion() === "eu-central-1" && $p->isDefault())) { $p->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: agent-created eu-central-1 default / aws_task_profile removed"
