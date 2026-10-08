#!/usr/bin/env bash
# Execution CLEANUP: delete vocabulary micon_vocab_task. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\taxonomy\Entity\Vocabulary::load("micon_vocab_task")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: micon_vocab_task removed"
