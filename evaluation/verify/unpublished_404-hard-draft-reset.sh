#!/usr/bin/env bash
# Execution RESET: ensure NO node titled 'U404 Hard Draft' exists, so verify FAILS until the agent
# creates an unpublished one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "U404 Hard Draft"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no node titled 'U404 Hard Draft'"
