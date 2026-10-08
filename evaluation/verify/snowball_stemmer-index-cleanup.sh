#!/usr/bin/env bash
# Introspection CLEANUP: delete index ss_known and server ss_known_srv. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  use Drupal\search_api\Entity\Index;
  if ($i = Index::load("ss_known")) { $i->delete(); }
  if ($s = Server::load("ss_known_srv")) { $s->delete(); }
' >/dev/null 2>&1
echo "cleanup: ss_known index and ss_known_srv server removed"
