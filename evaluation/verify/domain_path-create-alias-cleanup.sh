#!/usr/bin/env bash
# Execution CLEANUP: delete dp_task's aliases and the domain. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\domain\Entity\Domain;
  foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["domain_id"=>"dp_task"]) as $pa) { $pa->delete(); }
  if ($d = Domain::load("dp_task")) { $d->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: dp_task aliases + domain removed"
