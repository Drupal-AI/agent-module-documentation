#!/usr/bin/env bash
# Introspection CLEANUP: delete translator tmgg_auto_eval. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\tmgmt\Entity\Translator; if ($t=Translator::load("tmgg_auto_eval")){$t->delete();}' >/dev/null 2>&1
echo "cleanup: tmgg_auto_eval removed"
