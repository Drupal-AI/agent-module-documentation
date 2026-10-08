#!/usr/bin/env bash
# Execution CLEANUP: delete index jsa_task and server jsa_task_srv. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  use Drupal\search_api\Entity\Index;
  if ($i = Index::load("jsa_task")) { $i->delete(); }
  if ($s = Server::load("jsa_task_srv")) { $s->delete(); }
' >/dev/null 2>&1
echo "cleanup: jsa_task index and jsa_task_srv server removed"
