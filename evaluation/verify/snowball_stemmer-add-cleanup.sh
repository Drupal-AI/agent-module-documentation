#!/usr/bin/env bash
# Execution CLEANUP: delete index ss_task and server ss_task_srv. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  use Drupal\search_api\Entity\Index;
  if ($i = Index::load("ss_task")) { $i->delete(); }
  if ($s = Server::load("ss_task_srv")) { $s->delete(); }
' >/dev/null 2>&1
echo "cleanup: ss_task index and ss_task_srv server removed"
