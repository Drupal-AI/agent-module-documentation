#!/usr/bin/env bash
# Execution CLEANUP: delete the tdeepl_ftask translator provider. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\tmgmt\Entity\Translator; if ($t = Translator::load("tdeepl_ftask")) { $t->delete(); }' >/dev/null 2>&1
echo "cleanup: tdeepl_ftask translator removed"
