#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection SETUP: create a known facets_facet_source config entity whose URL processor
# is the pretty-paths one, so an inspecting agent can read it back off the live site.
# The source id `eval_pretty_source` and url_processor `facets_pretty_paths` are the knowns.
# Idempotent (re-saves the same source). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("facets_facet_source");
  $src = $storage->load("eval_pretty_source") ?: $storage->create(["id" => "eval_pretty_source", "name" => "eval:pretty_source"]);
  $src->set("url_processor", "facets_pretty_paths");
  $src->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: facets_facet_source eval_pretty_source url_processor=facets_pretty_paths"
