#!/usr/bin/env bash
# Introspection SETUP: create a text format pee_format with the 'Display embedded paragraphs'
# filter (paragraphs_entity_embed) enabled, so an agent can read back which format allows paragraph
# embedding. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("pee_format");
  if (!$f) { $f = FilterFormat::create(["format" => "pee_format", "name" => "PEE Format"]); }
  $f->setFilterConfig("paragraphs_entity_embed", ["status" => TRUE]);
  $f->save();
' >/dev/null 2>&1
echo "setup: text format pee_format has the paragraphs_entity_embed filter enabled"
