#!/usr/bin/env bash
# Introspection SETUP: assign the example page_Category tag a distinctive value on the node
# context so an agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$d=\Drupal::entityTypeManager()->getStorage("advanced_datalayer_defaults")->load("node"); $d->set("tags",["page_Category"=>"blog-EXMARK"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: advanced_datalayer_defaults.node tags.page_Category = blog-EXMARK"
