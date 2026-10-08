#!/usr/bin/env bash
# Introspection CLEANUP: delete vocabulary micon_vocab_med. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($v = \Drupal\taxonomy\Entity\Vocabulary::load("micon_vocab_med")) { $v->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: micon_vocab_med removed"
