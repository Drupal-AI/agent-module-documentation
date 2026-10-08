#!/usr/bin/env bash
# Introspection CLEANUP: restore quiz.settings autotitle_length to its shipped default (128).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset quiz.settings autotitle_length 128 -y >/dev/null 2>&1
echo "cleanup: quiz.settings autotitle_length restored to 128"
