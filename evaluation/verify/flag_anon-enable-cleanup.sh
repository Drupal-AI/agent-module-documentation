#!/usr/bin/env bash
# Execution CLEANUP: delete the flaganon_eval flag. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if($f=\Drupal::entityTypeManager()->getStorage("flag")->load("flaganon_eval")){$f->delete();}' >/dev/null 2>&1
echo "cleanup: flag flaganon_eval removed"
