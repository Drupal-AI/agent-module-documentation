#!/usr/bin/env bash
# Execution RESET: ensure no Article titled 'GLB Inline Page' exists, so verify FAILS until the agent
# creates one whose body loads a page URL in a GLightbox via glightbox_inline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\node\Entity\Node; foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"GLB Inline Page"]) as $n) { $n->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no node titled 'GLB Inline Page'"
