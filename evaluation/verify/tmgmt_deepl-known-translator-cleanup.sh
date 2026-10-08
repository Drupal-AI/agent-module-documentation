#!/usr/bin/env bash
# Introspection CLEANUP: delete the tdeepl_known translator provider. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\tmgmt\Entity\Translator; if ($t = Translator::load("tdeepl_known")) { $t->delete(); }' >/dev/null 2>&1
echo "cleanup: tdeepl_known translator removed"
