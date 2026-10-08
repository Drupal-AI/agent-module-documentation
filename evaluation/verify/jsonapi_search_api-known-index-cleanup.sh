#!/usr/bin/env bash
# Introspection CLEANUP: delete index jsa_known and server jsa_known_srv. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  use Drupal\search_api\Entity\Index;
  if ($i = Index::load("jsa_known")) { $i->delete(); }
  if ($s = Server::load("jsa_known_srv")) { $s->delete(); }
' >/dev/null 2>&1
echo "cleanup: jsa_known index and jsa_known_srv server removed"
