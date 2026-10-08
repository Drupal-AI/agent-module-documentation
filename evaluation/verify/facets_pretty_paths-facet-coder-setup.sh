#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection SETUP: create a pretty-paths facet source plus a facet on it whose
# per-facet coder third-party setting is a KNOWN value (taxonomy_term_coder), so an
# inspecting agent can read the coder off the live facet config.
# Knowns: source `eval_coder_source`, facet `eval_coder_facet`, coder `taxonomy_term_coder`.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ss = \Drupal::entityTypeManager()->getStorage("facets_facet_source");
  $src = $ss->load("eval_coder_source") ?: $ss->create(["id" => "eval_coder_source", "name" => "eval:coder_source"]);
  $src->set("url_processor", "facets_pretty_paths");
  $src->save();

  $fs = \Drupal::entityTypeManager()->getStorage("facets_facet");
  $facet = $fs->load("eval_coder_facet") ?: $fs->create([
    "id" => "eval_coder_facet",
    "name" => "Eval Coder Facet",
    "facet_source_id" => "eval_coder_source",
    "field_identifier" => "type",
    "url_alias" => "ctype",
    "widget" => ["type" => "links", "config" => []],
  ]);
  $facet->setThirdPartySetting("facets_pretty_paths", "coder", "taxonomy_term_coder");
  $facet->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: facet eval_coder_facet coder=taxonomy_term_coder (source eval_coder_source)"
