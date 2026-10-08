#!/usr/bin/env bash
# Execution RESET: vocabulary hct_vocab exists; clear the invalidation counter row for its handy
# bundle tag (handy_cache_tags:taxonomy_term:hct_vocab) so verify FAILS until an entity op fires it.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\taxonomy\Entity\Vocabulary; if(!Vocabulary::load("hct_vocab")){Vocabulary::create(["vid"=>"hct_vocab","name"=>"HCT Vocab"])->save();}' >/dev/null 2>&1
drush sqlq "DELETE FROM cachetags WHERE tag='handy_cache_tags:taxonomy_term:hct_vocab'" >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush sqlq "DELETE FROM cachetags WHERE tag='handy_cache_tags:taxonomy_term:hct_vocab'" >/dev/null 2>&1
echo "reset: hct_vocab exists; handy_cache_tags:taxonomy_term:hct_vocab invalidation cleared"
