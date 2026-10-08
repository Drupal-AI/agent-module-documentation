#!/usr/bin/env bash
# Introspection CLEANUP: delete reaction rule rer_eval. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("rules_reaction_rule"); if($e=$s->load("rer_eval")){$e->delete();}' >/dev/null 2>&1
echo "cleanup: rer_eval removed"
