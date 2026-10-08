#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Execution RESET: put the site in a clean baseline for the "switch a facet source to pretty
# paths" task. Create (or reset) a facets_facet_source `eval_hard_source` that uses the
# DEFAULT query_string url processor — so verify FAILs until the agent switches it to
# facets_pretty_paths. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("facets_facet_source");
  $src = $storage->load("eval_hard_source") ?: $storage->create(["id" => "eval_hard_source", "name" => "eval:hard_source"]);
  $src->set("url_processor", "query_string");
  $src->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: facets_facet_source eval_hard_source url_processor=query_string (baseline)"
