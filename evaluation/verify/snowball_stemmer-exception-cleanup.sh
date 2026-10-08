#!/usr/bin/env bash
# Execution CLEANUP: delete index ss_exc and server ss_exc_srv. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  use Drupal\search_api\Entity\Index;
  if ($i = Index::load("ss_exc")) { $i->delete(); }
  if ($s = Server::load("ss_exc_srv")) { $s->delete(); }
' >/dev/null 2>&1
echo "cleanup: ss_exc index and ss_exc_srv server removed"
