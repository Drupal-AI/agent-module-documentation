#!/usr/bin/env bash
# Execution RESET: ensure domain dp_task exists and has NO domain-specific alias '/dp-task-alias',
# so verify FAILS until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\domain\Entity\Domain;
  if (!Domain::load("dp_task")) {
    Domain::create(["id"=>"dp_task","hostname"=>"dp-task.example.com","name"=>"DP Task","scheme"=>"https","status"=>1,"weight"=>51])->save();
  }
  foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["domain_id"=>"dp_task"]) as $pa) { $pa->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: domain dp_task present, no domain-specific aliases"
