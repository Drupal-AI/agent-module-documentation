#!/usr/bin/env bash
# Introspection SETUP (entity_delete_log): insert one known deletion-log row so an inspecting agent
# can read the entity_delete_log table. Idempotent (deletes prior seed first). Exit 0.
set -uo pipefail
cd /var/www/html
drush sqlq "DELETE FROM entity_delete_log WHERE entity_title = 'edl_seed_title'" >/dev/null 2>&1
drush sqlq "INSERT INTO entity_delete_log (entity_id, entity_type, entity_bundle, entity_title, author, revisions, created, deleted, uid) VALUES (4242, 'node', 'article', 'edl_seed_title', 1, NULL, NULL, 1700000000, 1)" >/dev/null 2>&1
echo "setup: entity_delete_log row entity_title=edl_seed_title (entity_type=node) inserted"
