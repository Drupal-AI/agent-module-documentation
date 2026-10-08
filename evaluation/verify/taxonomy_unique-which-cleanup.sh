#!/usr/bin/env bash
# Introspection CLEANUP: delete vocabularies tu_on and tu_off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\taxonomy\Entity\Vocabulary; foreach(["tu_on","tu_off"] as $x){if($v=Vocabulary::load($x)){$v->delete();}}' >/dev/null 2>&1
echo "cleanup: vocabularies tu_on, tu_off removed"
