#!/usr/bin/env bash
# Execution CLEANUP: remove the 'TOC Api Example Blog' Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "TOC Api Example Blog"]) as $n) { $n->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'TOC Api Example Blog' removed"
