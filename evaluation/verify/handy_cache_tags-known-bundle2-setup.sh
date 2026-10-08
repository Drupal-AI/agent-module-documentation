#!/usr/bin/env bash
# Introspection SETUP: content type hct_probe2 (agent derives its handy bundle tag).
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\node\Entity\NodeType; if(!NodeType::load("hct_probe2")){NodeType::create(["type"=>"hct_probe2","name"=>"HCT Probe 2"])->save();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content type hct_probe2 exists (bundle tag handy_cache_tags:node:hct_probe2)"
