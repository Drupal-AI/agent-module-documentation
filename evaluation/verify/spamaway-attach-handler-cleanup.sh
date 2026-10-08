#!/usr/bin/env bash
# Execution CLEANUP: delete webform spamaway_eval_h1. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\webform\Entity\Webform; if ($w = Webform::load("spamaway_eval_h1")) { $w->delete(); }' >/dev/null 2>&1
echo "cleanup: webform spamaway_eval_h1 removed"
