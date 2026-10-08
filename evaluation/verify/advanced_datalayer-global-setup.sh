#!/usr/bin/env bash
# Introspection SETUP: set a distinctive site_Name datalayer value on the 'global' context. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("advanced_datalayer_defaults")->load("global");
  $d->set("tags", ["site_Name" => "ACME-EVAL"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: advanced_datalayer_defaults.global tags.site_Name = ACME-EVAL"
