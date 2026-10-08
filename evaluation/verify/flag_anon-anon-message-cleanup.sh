#!/usr/bin/env bash
# Introspection CLEANUP: delete the flaganon_eval flag created by setup. Restores baseline
# (no such flag). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if($f=\Drupal::entityTypeManager()->getStorage("flag")->load("flaganon_eval")){$f->delete();}' >/dev/null 2>&1
echo "cleanup: flag flaganon_eval removed"
